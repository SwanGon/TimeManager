<template>
  <div class="working-time-creator">
    <h2>Create or update Working Time</h2>

    <div class="menu-container">
      <FullCalendar :options="calendarProps" ref="cal"/>

      <div class="mx-20" v-if="currentRole != 'user'">
        <h3>Sélectionnez les utilisateurs :</h3>
        <select v-model="userId">
          <option v-for="user in users" :key="user.id" :value="user.id">
            {{ user.username }}
          </option>
        </select>
        <button @click="refetching">Soumettre</button>
      </div>
    </div>

    <VaModal v-model="showModal" cancel-text="Annuler" v-bind="isCreate ? { onOk: createWorkingTimes, okText: 'Créer le Working time' } : { onOk: modifyWorkingTimes, okText: 'Modifier le Working time' }">
      <template #header v-if="!isCreate">
        <div style="justify-content: end;">
          <VaButton color="danger" size="small" @click="actionOfDelete">
            Supprimer l'horaire de travail
          </VaButton>
        </div>
      </template>
      <div class="zone-modal">
        <p>
          début du working time
        </p>
        <VaDateInput v-model="startDate"/>
        <VaTimeInput v-model="startTime"/>
      </div>
      <div class="zone-modal">
        <p>
          fin du working time
        </p>
        <VaDateInput v-model="endDate"/>
        <VaTimeInput v-model="endTime"/>
      </div>
    </VaModal>
  </div>
</template>

<script setup>
  import { ref, computed, useTemplateRef, onMounted } from 'vue';
  import axios from 'axios';
  import FullCalendar from '@fullcalendar/vue3';
  import dayGridPlugin from '@fullcalendar/daygrid'
  import interactionPlugin from '@fullcalendar/interaction'
  import timegridPlugin from '@fullcalendar/timegrid'

  const startTime = ref(null);
  const startDate = ref(null)
  const endTime = ref(null);
  const endDate = ref(null);
  const selectedWt = ref(null)
  const userId = ref(null);
  const showModal = ref(false);
  const currentRole = localStorage.getItem('userRole')
  const currentUserId = localStorage.getItem('userId')
  let cal = useTemplateRef('cal')
  let isCreate = true

  const users = ref([]);

  const calendarProps = {
          plugins: [ timegridPlugin, dayGridPlugin, interactionPlugin ],
          navLinks: true,
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
          },
          allDaySlot: false,
          locale:"fr",
          timeZone:"Europe/Paris",
          events: (fetchInfo, succesCallback, failureCallback) => fetchEvents(fetchInfo, succesCallback, failureCallback),
          views: {
            timeGrid: {
              selectable : true,
              select: (info) => actionOfSelect(info)
            }
          },
          eventClick: (info) => actionOfClick(info)
        }

  const fetchEvents = async (info, succesCallback, failureCallback) => {
    console.log('fetching...');
    
    if (!userId.value) {
      failureCallback();
      return;
    }
    
    const response = await axios.get(`/api/workingtimes/${userId.value}?working_start=${info.start.toISOString()}&working_end=${info.end.toISOString()}`);
    
    succesCallback(
      response.data.data.map(
        (event) => {
          return {
            start: event.start,
            end: event.end,

            extendedProps: {
              wtID : event.id
            }
          }
        }
      )
    );
  };

  const createWorkingTimes = async () => {
    if (!startDate.value || !endDate.value || !startTime.value || !endTime.value || !userId.value) {
      alert("Please fill in all fields and select a User ID.");
      return;
    }

    const workingTimeData = {
      user_id: userId.value,
      working_start: formatDateTime(startDate.value, startTime.value),
      working_end: formatDateTime(endDate.value, endTime.value),
    };

    try {
      const response = await axios.post(`/api/workingtimes/${userId.value}`, workingTimeData, {
        headers: {
          'Content-Type': 'application/json',
        },
      });
      refetching()
    } catch (error) {
      console.error('Error creating working time:', error);
      alert('Failed to create working time. Please try again.');
    }
  };

  const modifyWorkingTimes = async () => {
    if (!startDate.value || !endDate.value || !startTime.value || !endTime.value || !userId.value) {
      alert("Please fill in all fields and select a User ID.");
      return;
    }

    const workingTimeData = {
      working_start: formatDateTime(startDate.value, startTime.value),
      working_end: formatDateTime(endDate.value, endTime.value),
    };

    try {
      const response = await axios.put(`/api/workingtimes/${selectedWt.value.extendedProps.wtID}`, workingTimeData, {
        headers: {
          'Content-Type': 'application/json',
        },
      });
      refetching()
    } catch (error) {
      console.error('Error modifying working time:', error);
      alert('Failed to modify working time. Please try again.');
    }
  }

  const deleteWorkingTimes = async () => {
    try {
      const response = await axios.delete(`/api/workingtimes/${selectedWt.value.extendedProps.wtID}`);
      refetching()
    } catch (error) {
      console.error('Error deleting working time:', error);
      alert('Failed to delete working time. Please try again.');
    }
  }

  const fetchUsers = async () => {
    if (currentRole == "user") {
      userId.value = currentUserId
      refetching()
    } else {
      try {
        const response = await axios.get(`/api/users`);
        users.value = response.data.data;
        
        // Définir la première valeur comme valeur par défaut si des utilisateurs sont disponibles
        if (users.value.length > 0) {
          userId.value = users.value[0].id;
          refetching()
        }
      } catch (error) {
        console.error('Erreur lors de la récupération des utilisateurs:', error);
      }
    }
  };

  function formatDateTime(date, time) {
    const [hours, minutes] = time.toTimeString().split(':');
    console.log(date.toISOString());
    
    return `${date.getUTCFullYear()}-${date.getMonth()+1}-${date.getUTCDate()} ${hours}:${minutes}:00`;
  }

  const actionOfSelect = (info) => {
    if (!info.allDay) {
      startTime.value = new Date(info.start);
      startTime.value.setHours(startTime.value.getHours() - 1)
      startDate.value = new Date(info.start); 
      endTime.value = new Date(info.end); 
      endTime.value.setHours(endTime.value.getHours() - 1)
      endDate.value = new Date(info.end); 

      isCreate = true;
      showModal.value = !showModal.value;
    }
  };

  const actionOfClick = (info) => {
    console.log(info.event);
    
    startTime.value = new Date(info.event.start); 
    startTime.value.setHours(startTime.value.getHours() - 1)
    startDate.value = new Date(info.event.start); 
    endTime.value = new Date(info.event.end);
    endTime.value.setHours(endTime.value.getHours() - 1)
    endDate.value = new Date(info.event.end); 
    selectedWt.value = info.event;

    isCreate = false;
    showModal.value = !showModal.value;
  }

  const actionOfDelete = () => {
    deleteWorkingTimes()
    showModal.value = false
  }

  const refetching = () => {
    cal.value.calendar.getEventSources().map((el) => el.refetch())
  }

  const submitSelectedUser = () => {
    console.log('Utilisateur sélectionné:', userId.value);
    
  };

  onMounted(() => {
    fetchUsers();
  });
  
</script>

<style scoped>
.menu-container{
  display: flex;
  flex-direction: row;
}

.zone-modal {
  margin-top: 5;
}
.working-time-creator {
  color: black;
  max-width: 1200px; /* Adjust width as needed */
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  background-color: #f9f9f9;
}

.input-group {
  margin-bottom: 20px;
}

.time-picker {
  margin-bottom: 20px;
  display: flex;
}

.user-selection {
  margin-bottom: 20px;
}

button {
  padding: 10px 15px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

label {
  margin-bottom: 5px;
}

.time-range {
  font-weight: bold;
  color: #333;
}
</style>
