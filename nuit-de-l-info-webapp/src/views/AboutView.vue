<script setup lang="ts">
import luigi from '@/assets/luigi.webp'
import mario from '@/assets/mario.webp'
import { onBeforeUnmount, onMounted, ref } from 'vue'
import GameCube from '@/components/konami-code/GameCube.vue'

onMounted(() => {
  const main = document.querySelector('main')
  if (!main?.classList.contains('background-dark')) {
    main?.classList.add('background-dark')
  }
})

onBeforeUnmount(() => {
  const main = document.querySelector('main')
  if (main?.classList.contains('background-dark')) {
    main?.classList.remove('background-dark')
  }
})

const dialogues = ref([
  { side: 'right', text: 'Quel est l’objectif principal de la démarche NIRD ?' },
  {
    side: 'left',
    text: 'La démarche NIRD vise à promouvoir l’indépendance et la responsabilité numérique dans le milieu scolaire.',
  },
  { side: 'right', text: 'D’où vient l’initiative NIRD et que cherche-t-elle à faire ?' },
  {
    side: 'left',
    text: 'C’est une initiative venant “d’en bas” qui cherche à convaincre les niveaux supérieurs de son importance et de sa pertinence.',
  },
  { side: 'right', text: 'Quels sont les principaux objectifs concrets de la démarche NIRD ?' },
  {
    side: 'left',
    text: 'Allonger la durée de vie du matériel informatique, devenir moins dépendant des grandes entreprises technologiques, inculquer de bonnes habitudes numériques aux étudiants et dégager des fonds pour améliorer la qualité de l’éducation.',
  },
  { side: 'right', text: 'À quoi sert le mini-jeu proposé ?' },
  {
    side: 'left',
    text: 'Il permet de comprendre de manière ludique les objectifs et les intérêts de la démarche NIRD.',
  },
  { side: 'right', text: 'Comment peut-on rejoindre ou soutenir NIRD ?' },
  {
    side: 'left',
    text: "En visitant l’onglet <a href='https://edurl.fr/tchap-demarche-nird' target='_blank'>“Nous rejoindre”</a> pour accéder aux forums, obtenir plus d’informations et découvrir comment agir pour intégrer son école dans la démarche.",
  },
])
</script>

<template>
  <div class="back">
    <h1>À propos de la démarche NIRD</h1>
    <h2>(Numérique Inclusif Responsable Durable)</h2>
    <div
      v-for="(dialogue, index) in dialogues"
      :key="index"
      :class="dialogue.side === 'right' ? 'eight-bit-right' : 'eight-bit-left'"
    >
      <img :src="dialogue.side === 'right' ? luigi : mario" alt="Avatar" class="avatar" />

      <div :class="dialogue.side" v-html="dialogue.text"></div>
    </div>
  </div>
  <div class="game-cube">
    <GameCube />
  </div>
</template>

<style>
@import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

:root {
  --green-color: #28a428;
  --red-color: #e34242;
}

main.background-dark {
  background-color: #282828;
}

.back {
  background-color: #282828;
  font-family: 'Press Start 2P', monospace;
  color: var(--green-color);
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px;
  box-sizing: border-box;
}

/* Texte */

.back h2 {
  margin-bottom: 40px;
  color: var(--red-color);
}

.eight-bit-left,
.eight-bit-right {
  display: flex;
  align-items: flex-start;
  gap: 10px;
  margin: 10px 0;
  border-radius: 0;
  position: relative;
  image-rendering: pixelated;
  font-size: 10px;
  overflow: visible;
}

.eight-bit-left {
  flex-direction: row-reverse;
  border-color: #970404;
  color: var(--red-color);
  margin-left: auto;
  text-align: left;
  max-width: 60%;
}

.eight-bit-right {
  flex-direction: row;
  border-color: #049004;
  color: #06ae06;
  margin-right: auto;
  text-align: right;
  max-width: 70%;
}

.eight-bit-left > .left,
.eight-bit-right > .right {
  padding: 15px 25px;
  box-shadow:
    4px 0 0 0,
    0 4px 0 0,
    -4px 0 0,
    0 -4px 0 0;
  border-radius: 0;
}

.eight-bit-left a,
.eight-bit-right a {
  color: inherit;
}

/* Avatar */

.avatar {
  width: 40px;
  height: 40px;
  object-fit: cover;
  box-shadow:
    5px 0 0 0,
    0 5px 0 0,
    -5px 0 0,
    0 -5px 0 0;
  position: relative;
  flex-shrink: 0;
}

.eight-bit-right .avatar {
  margin-left: -12px;
}

.eight-bit-left .avatar {
  margin-right: -12px;
  transform: scaleX(-1);
}

.game-cube {
  margin-top: 60px;
  color: white;
}
</style>
