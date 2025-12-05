<template>
  <div>
    <h1>Connecte TOI</h1>
    <form @submit.prevent="login">
      <div>
        <label for="email">Name :</label>
        <input type="text" id="email" v-model="email" required />
      </div>
      <button type="submit">Se connecter</button>
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
