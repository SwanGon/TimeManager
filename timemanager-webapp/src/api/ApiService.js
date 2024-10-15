import axios from 'axios';

class ApiService {
    constructor() {
        if (!ApiService.instance) {
            this.apiClient = axios.create({
                baseURL: process.env.VUE_APP_API_URL,
                timeout: 1000,
                headers: {'Content-Type': 'application/json'}
            });
            ApiService.instance = this;
        }
        return ApiService.instance;
    }

    async getData(endpoint) {
        try {
            const response = await this.apiClient.get(endpoint);
            return response.data;
        } catch (error) {
            console.error('Erreur lors de la récupération des données:', error);
            throw error;
        }
    }

    async postData(endpoint, data) {
        try {
            const response = await this.apiClient.post(endpoint, data);
            return response.data;
        } catch (error) {
            console.error('Erreur lors de l\'envoi des données:', error);
            throw error;
        }
    }

    // Ajoutez d'autres méthodes pour PUT, DELETE, etc. selon vos besoins
}

const instance = new ApiService();
Object.freeze(instance);

export default instance;
