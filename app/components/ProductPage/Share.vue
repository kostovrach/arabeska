<template>
    <SpeedDial ></SpeedDial>
</template>

<script setup lang="ts">
    // SEO & Meta ===============================================
    useHead({
        title: ''
    })
    // ==========================================================
    interface IShareLink {
        icon: string;
        link: string;
        hoverColor?: string; 
    }

    const shareLinks = [
        {
            icon: '',
            link: '',
            hoverColor: ''
        }
    ]
</script>

<style scoped></style>
