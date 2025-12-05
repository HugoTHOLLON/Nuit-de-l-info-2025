<template>
  <div class="d-flex flex-column gap-3">
    <h1 class="text-gradient-primary">Saisir votre nom pour démarrer le jeu</h1>
    <form @submit.prevent="login" class="d-flex flex-column gap-3">
      <div>
        <label for="email" style="font-size: 1.3rem">Nom : </label>
        <input class="w-100" type="text" id="email" v-model="email" required />
      </div>
      <button type="submit" class="btn btn-outline-primary">Se connecter</button>
    </form>
  </div>
</template>

<script setup lang="ts">
import router from '@/router'
import { ref } from 'vue'

const email = ref('')

const login = () => {
  router.push({ path: '/gameLoop', query: { name: email.value } })
}
</script>

<style scoped>
#email {
  padding: 5px;
  font-size: 1rem;
}
</style>
