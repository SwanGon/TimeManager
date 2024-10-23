<script setup>
import ButtonComponent from "@/components/general/ButtonComponent.vue";
import { VPdfViewer } from "@vue-pdf-viewer/viewer";
import { ref } from "vue";
const showPdf = ref(false);
const pdfUrl = new URL('../asset/contract/Contrat de travail.pdf', import.meta.url).href;
const togglePdf = ()=>{
    showPdf.value = !showPdf.value;
}
</script>
<template>
    <div>
        <ButtonComponent title="Contracts" @click="togglePdf"/>
        <div :style="{ width: '100vw', height: '100vh' }" v-if="showPdf" >
            <VPdfViewer :src="pdfUrl"/>
        </div>
        <ButtonComponent title="Contact" path="/contact"/>
    </div>
</template>