import type { DirectiveBinding } from 'vue';

interface PhoneMaskHandlers {
    input: (e: Event) => void;
    keydown: (e: KeyboardEvent) => void;
    paste: (e: ClipboardEvent) => void;
    focus: (e: FocusEvent) => void;
}

interface PhoneMaskElement extends HTMLInputElement {
    _phoneMaskHandlers?: PhoneMaskHandlers;
    _isInternalUpdate?: boolean;
    _lastApplied?: string;
}

const MASK = '+7 (___) ___-__-__';
const DIGIT_RE = /\d/;

function formatPhone(value: string): string {
    const digits = value.replace(/\D/g, '');
    let formatted = '+7 (';

    if (digits.length > 1) {
        formatted += digits.slice(1, 4);
    }

    if (digits.length >= 4) {
        formatted += ') ' + digits.slice(4, 7);
    }

    if (digits.length >= 7) {
        formatted += '-' + digits.slice(7, 9);
    }

    if (digits.length >= 9) {
        formatted += '-' + digits.slice(9, 11);
    }

    return formatted;
}

function getDigitsOnly(value: string): string {
    return value.replace(/\D/g, '');
}

function clamp(min: number, v: number, max: number) {
    return Math.min(max, Math.max(min, v));
}

function setCaretPosition(input: HTMLInputElement, position: number) {
    const pos = clamp(0, Math.floor(position), input.value.length);
    setTimeout(() => {
        try {
            input.setSelectionRange(pos, pos);
        } catch {
            // silent
        }
    }, 0);
}

function findPosByDigitsCount(formattedWhereMask: string, digitsCount: number): number {
    if (digitsCount <= 0) {
        return Math.min(4, formattedWhereMask.length);
    }
    let count = 0;
    for (let i = 0; i < formattedWhereMask.length; i++) {
        if (DIGIT_RE.test(formattedWhereMask.charAt(i))) {
            count++;
            if (count === digitsCount) {
                return i + 1;
            }
        }
    }
    return formattedWhereMask.length;
}

function normalizeDigits(raw: string): string {
    let digits = getDigitsOnly(raw);
    if (digits.length === 0) digits = '7';
    else if (digits[0] === '8') digits = '7' + digits.slice(1);
    else if (digits[0] !== '7') digits = '7' + digits;
    if (digits.length > 11) digits = digits.slice(0, 11);
    return digits;
}

function applyMask(input: PhoneMaskElement, rawValue: string, dispatch = false): string {
    const digits = normalizeDigits(rawValue);
    const formatted = formatPhone(digits);
    const withMask = formatted + MASK.slice(formatted.length);

    input._isInternalUpdate = true;
    input.value = withMask;
    input._lastApplied = withMask;
    input._isInternalUpdate = false;

    if (dispatch) {
        input.dispatchEvent(new Event('input', { bubbles: true }));
    }

    return withMask;
}

export default {
    mounted(el: Element, _binding: DirectiveBinding) {
        if (!(el instanceof HTMLInputElement)) {
            return;
        }

        const input = el as PhoneMaskElement;

        if (!input.value) {
            input.value = MASK;
        } else {
            const digits = getDigitsOnly(input.value);
            if (digits.length > 0) {
                input.value = formatPhone(digits);
                if (input.value.length < MASK.length) {
                    input.value = input.value + MASK.slice(input.value.length);
                }
            } else {
                input.value = MASK;
            }
        }

        input._lastApplied = input.value;

        const handleInput = (e: Event) => {
            if (!e.isTrusted) return;

            const target = e.target as HTMLInputElement | null;
            if (!target) return;

            if ((target as PhoneMaskElement)._isInternalUpdate) return;

            const cursorPos = target.selectionStart ?? 0;
            const oldValue = target.value;
            const oldDigits = getDigitsOnly(oldValue);

            const newValue = target.value;
            let newDigits = getDigitsOnly(newValue);

            if (newDigits.length > 11) {
                newDigits = newDigits.slice(0, 11);
            }

            if (newDigits.length === 0) {
                newDigits = '7';
            } else if (newDigits[0] === '8') {
                newDigits = '7' + newDigits.slice(1);
            } else if (newDigits[0] !== '7') {
                newDigits = '7' + newDigits;
            }

            const formatted = formatPhone(newDigits);
            const withMask = formatted + MASK.slice(formatted.length);

            const digitsBeforeCursor = getDigitsOnly(newValue.slice(0, cursorPos)).length;

            (target as PhoneMaskElement)._isInternalUpdate = true;
            target.value = withMask;
            (target as PhoneMaskElement)._lastApplied = withMask;
            (target as PhoneMaskElement)._isInternalUpdate = false;

            const newPos = findPosByDigitsCount(withMask, digitsBeforeCursor);
            setCaretPosition(target, newPos);

            target.dispatchEvent(new Event('input', { bubbles: true }));
        };

        const handleKeydown = (e: KeyboardEvent) => {
            const target = e.target as HTMLInputElement | null;
            if (!target) return;

            const selStart = target.selectionStart ?? 0;
            const selEnd = target.selectionEnd ?? 0;
            if (selStart !== selEnd) return;

            if (e.key === 'Backspace') {
                if (selStart <= 4) {
                    e.preventDefault();
                    setCaretPosition(target, 4);
                    return;
                }

                e.preventDefault();

                let posToCheck = selStart - 1;
                while (posToCheck >= 0 && !DIGIT_RE.test(target.value.charAt(posToCheck) ?? '')) {
                    posToCheck--;
                }
                if (posToCheck < 1) {
                    setCaretPosition(target, Math.max(4, selStart));
                    return;
                }

                const allDigits = getDigitsOnly(target.value);
                const digitsBeforePos = getDigitsOnly(target.value.slice(0, posToCheck + 1));
                const digitIndex = Math.max(0, digitsBeforePos.length - 1);
                const newDigits = allDigits.slice(0, digitIndex) + allDigits.slice(digitIndex + 1);

                let norm = newDigits;
                if (norm.length === 0) norm = '7';
                else if (norm[0] === '8') norm = '7' + norm.slice(1);
                else if (norm[0] !== '7') norm = '7' + norm;

                const formatted = formatPhone(norm);
                const withMask = formatted + MASK.slice(formatted.length);

                (target as PhoneMaskElement)._isInternalUpdate = true;
                target.value = withMask;
                (target as PhoneMaskElement)._lastApplied = withMask;
                (target as PhoneMaskElement)._isInternalUpdate = false;

                const desiredDigitsLeft = Math.max(0, digitsBeforePos.length - 1);
                const newPos = findPosByDigitsCount(withMask, desiredDigitsLeft);
                setCaretPosition(target, newPos);

                target.dispatchEvent(new Event('input', { bubbles: true }));
            } else if (e.key === 'Delete') {
                if (selStart >= target.value.length) return;

                e.preventDefault();

                let posToCheck = selStart;
                while (
                    posToCheck < target.value.length &&
                    !DIGIT_RE.test(target.value.charAt(posToCheck) ?? '')
                ) {
                    posToCheck++;
                }

                if (posToCheck >= target.value.length || posToCheck < 1) {
                    setCaretPosition(target, selStart);
                    return;
                }

                const allDigits = getDigitsOnly(target.value);
                const digitsBeforePos = getDigitsOnly(target.value.slice(0, posToCheck + 1));
                const digitIndex = Math.max(0, digitsBeforePos.length - 1);

                const newDigits = allDigits.slice(0, digitIndex) + allDigits.slice(digitIndex + 1);

                let norm = newDigits;
                if (norm.length === 0) norm = '7';
                else if (norm[0] === '8') norm = '7' + norm.slice(1);
                else if (norm[0] !== '7') norm = '7' + norm;

                const formatted = formatPhone(norm);
                const withMask = formatted + MASK.slice(formatted.length);

                (target as PhoneMaskElement)._isInternalUpdate = true;
                target.value = withMask;
                (target as PhoneMaskElement)._lastApplied = withMask;
                (target as PhoneMaskElement)._isInternalUpdate = false;

                const desiredDigitsLeft = Math.max(
                    0,
                    getDigitsOnly(target.value.slice(0, selStart)).length
                );
                const newPos = findPosByDigitsCount(withMask, desiredDigitsLeft);
                setCaretPosition(target, newPos);

                target.dispatchEvent(new Event('input', { bubbles: true }));
            } else {
                return;
            }
        };

        const handlePaste = (e: ClipboardEvent) => {
            e.preventDefault();
            const target = e.target as HTMLInputElement | null;
            if (!target) return;

            const pasted = e.clipboardData?.getData('text') ?? '';
            let digits = getDigitsOnly(pasted);
            if (digits.length === 0) return;

            if (digits[0] === '8') {
                digits = '7' + digits.slice(1);
            } else if (digits[0] !== '7') {
                digits = '7' + digits;
            }

            if (digits.length > 11) digits = digits.slice(0, 11);

            const formatted = formatPhone(digits);
            const withMask = formatted + MASK.slice(formatted.length);

            (target as PhoneMaskElement)._isInternalUpdate = true;
            target.value = withMask;
            (target as PhoneMaskElement)._lastApplied = withMask;
            (target as PhoneMaskElement)._isInternalUpdate = false;

            setCaretPosition(target, formatted.length);
            target.dispatchEvent(new Event('input', { bubbles: true }));
        };

        const handleFocus = (e: FocusEvent) => {
            const target = e.target as HTMLInputElement | null;
            if (!target) return;
            const digits = getDigitsOnly(target.value);
            if (digits.length <= 1) {
                setCaretPosition(target, 4);
            }
        };

        input._phoneMaskHandlers = {
            input: handleInput,
            keydown: handleKeydown,
            paste: handlePaste,
            focus: handleFocus,
        };

        input.addEventListener('input', handleInput);
        input.addEventListener('keydown', handleKeydown);
        input.addEventListener('paste', handlePaste);
        input.addEventListener('focus', handleFocus);
    },

    updated(el: Element, _binding: DirectiveBinding) {
        if (!(el instanceof HTMLInputElement)) return;
        const input = el as PhoneMaskElement;

        if (input._isInternalUpdate) return;

        const domDigits = getDigitsOnly(input.value);
        const lastDigits = input._lastApplied ? getDigitsOnly(input._lastApplied) : null;

        if (lastDigits === null) {
            applyMask(input, input.value, true);
            return;
        }

        if (domDigits !== lastDigits) {
            applyMask(input, input.value, true);
        }
    },

    unmounted(el: Element) {
        if (!(el instanceof HTMLInputElement)) return;
        const input = el as PhoneMaskElement;
        if (input._phoneMaskHandlers) {
            input.removeEventListener('input', input._phoneMaskHandlers.input);
            input.removeEventListener('keydown', input._phoneMaskHandlers.keydown);
            input.removeEventListener('paste', input._phoneMaskHandlers.paste);
            input.removeEventListener('focus', input._phoneMaskHandlers.focus);
            delete input._phoneMaskHandlers;
        }
        delete input._isInternalUpdate;
        delete input._lastApplied;
    },
};
