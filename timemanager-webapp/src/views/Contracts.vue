<script setup>
import ButtonComponent from "@/components/general/ButtonComponent.vue";
import { VPdfViewer } from "@vue-pdf-viewer/viewer";
import { ref, onMounted } from "vue";
import { VaModal } from 'vuestic-ui';
import axios from 'axios';

const showPdf = ref(false);
const showManagerSelect = ref(false);
const managers = ref([]);
const selectedManager = ref('');
const pdfUrl = new URL('../asset/contract/Contrat de travail.pdf', import.meta.url).href;

const togglePdf = () => {
    showPdf.value = !showPdf.value;
}

const toggleManagerSelect = () => {
    showManagerSelect.value = !showManagerSelect.value;
}

onMounted(async () => {
    try {
        const [managersResponse, supervisorsResponse] = await Promise.all([
            axios.get('/api/managers'),
            axios.get('/api/supervisors')
        ]);
        
        managers.value = [
            ...managersResponse.data.data.map(manager => ({ ...manager, role: { title: 'manager' } })),
            ...supervisorsResponse.data.data.map(supervisor => ({ ...supervisor, role: { title: 'supervisor' } }))
        ];
    } catch (error) {
        console.error('Error fetching managers and supervisors:', error);
    }
});

</script>

<template>
    <div class="flex justify-center items-center h-screen px-4">
        <div class="flex gap-4 flex-col max-w-md mx-auto">
        <ButtonComponent title="Contracts" @click="togglePdf" class="text-center"/>
        <div :style="{ width: '100vw', height: '100vh' }" v-if="showPdf">
            <VPdfViewer :src="pdfUrl"/>
            <button @click="togglePdf" class="bg-button hover:bg-button-hover text-button-text shrink py-2 px-4 rounded items-center absolute top-4 right-4">
                <span class="text-button-text">Fermer</span>
            </button>
        </div>

        <button @click="toggleManagerSelect" class="bg-button hover:bg-button-hover text-button-text shrink py-2 px-4 rounded items-center">
            <span class="text-button-text">Contact</span>
        </button>
        </div>

        <!-- Popup Modal -->
        <VaModal v-model="showManagerSelect" title="Select a Manager" :width="400">
            <template #content>
                <select v-model="selectedManager" class="bg-button text-button-text py-2 px-4 rounded mr-2 w-small mb-4">
                <option value="" disabled>Select a manager or supervisor</option>
                <option v-for="manager in managers" :key="manager.id" :value="manager.email">
                    - {{ manager.username }} ({{ manager.email }}, {{ manager.role ? manager.role.title:'' }})
                </option>
                </select>

                <div class="flex justify-end gap-2">
                <button @click="toggleManagerSelect" class="bg-button hover:bg-button-hover text-button-text shrink py-2 px-4 rounded items-center">Cancel</button>
                <a :href="`mailto:${selectedManager}`" class="bg-button hover:bg-button-hover text-button-text px-4 py-2 rounded items-center">
                    Contact
                </a>
                </div>
            </template>
        </VaModal>
    </div>
</template>
