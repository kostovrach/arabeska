export type SortKey = 'price_asc' | 'price_desc' | 'date_desc';

export interface IFilterState {
  discountOnly: boolean;
  structures: string[];
  reasons: string[];
  styles: string[];
  priceMin: number | null;
  priceMax: number | null;
  sort: SortKey | null;
}