<template>
  <div>
    <h1>Tycoon NIRD</h1>
    <p>Année : {{ currentYear }}</p>
    <p>Jour : {{ currentDay }}</p>
    <p>Budget : €{{ budget.toFixed(2) }}</p>
    <p>Engagement élèves : {{ engagement.toFixed(2) }}</p>
    <p>Intérêt moyen des profs : {{ averageInterest.toFixed(2) }}</p>
    <button @click="startGame">Démarrer le jeu</button>
    <button @click="stopGame">Arrêter le jeu</button>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

interface PC {
  id: number
  status: 'neuf' | 'obsolète' | 'hors-service' | 'hors-dusage'
  os: 'Windows' | 'Linux'
}

interface Professor {
  id: number
  interest: number // 0 à 100
}

// Variables de jeu
const currentYear = ref(0)
const currentDay = ref(1)
const budget = ref(10000)
const engagement = ref(10)
const averageInterest = ref(50)
const pcs = ref<PC[]>([])
const professors = ref<Professor[]>([])
let gameInterval: number | null = null

const cycleDuration = 5 * 1000 // 10 secondes = 1 jour
const daysPerYear = 365

// Game loop
function gameLoop() {
  console.log(`Jour ${currentDay.value}, Année ${currentYear.value}`)

  handleDailyEvents()
  updatePCs()
  updateEngagement()
  updateProfInterest()

  if (currentDay.value === daysPerYear) {
    calculateAnnualSubventions()
  }

  currentDay.value++
  if (currentDay.value > daysPerYear) {
    currentDay.value = 1
    currentYear.value++
  }

  checkGameOver()
}

function handleDailyEvents() {
  pcs.value.forEach((pc) => {
    if (Math.random() > 0.995) {
      // 0.5% chance par jour
      pc.status = pc.status === 'hors-service' ? 'hors-dusage' : 'hors-service'
      console.log(`PC ${pc.id} endommagé !`)
    }
  })
}

function updatePCs() {
  pcs.value.forEach((pc) => {
    if (pc.os === 'Windows' && pc.status === 'obsolète') {
      engagement.value -= 0.05
    }
    if (pc.os === 'Linux' && pc.status === 'neuf') {
      engagement.value += 0.05
    }
  })
  engagement.value = Math.max(0, engagement.value)
}

function updateEngagement() {
  const totalInterest = professors.value.reduce((sum, prof) => sum + prof.interest, 0)
  averageInterest.value = totalInterest / professors.value.length
}

function updateProfInterest() {
  professors.value.forEach((prof) => {
    const linuxExposure = pcs.value.filter((pc) => pc.os === 'Linux' && pc.status === 'neuf').length
    prof.interest += linuxExposure * 0.01 // petit boost quotidien
    prof.interest = Math.min(100, prof.interest) // max 100
  })
}

function calculateAnnualSubventions() {
  const base = 1000
  const subvention = base + engagement.value * 10 + averageInterest.value * 5
  budget.value += subvention
  console.log(`Subventions annuelles reçues : €${subvention.toFixed(2)}`)
}

function checkGameOver() {
  if (budget.value <= 0) {
    stopGame()
    alert('Game Over : budget épuisé !')
  }
}

function startGame() {
  if (gameInterval) return
  gameInterval = window.setInterval(gameLoop, cycleDuration)
}

function stopGame() {
  if (gameInterval) {
    clearInterval(gameInterval)
    gameInterval = null
  }
}

onMounted(() => {
  pcs.value = [
    { id: 1, status: 'neuf', os: 'Windows' },
    { id: 2, status: 'obsolète', os: 'Windows' },
    { id: 3, status: 'hors-service', os: 'Linux' },
  ]
  professors.value = [
    { id: 1, interest: 50 },
    { id: 2, interest: 40 },
  ]
})

onUnmounted(() => stopGame())
</script>
