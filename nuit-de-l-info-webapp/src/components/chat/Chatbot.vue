<!-- MERCI CHAT -->

<template>
  <!-- Button -->
  <button class="chat-button" @click="open = !open">💬</button>

  <!-- Popup -->
  <transition name="fade">
    <div v-if="open" class="chat-container">
      <div class="chat-header">
        <span>Theo (trouver un nom)</span>
        <button class="close-btn" @click="open = false">×</button>
      </div>

      <div class="chat-messages" ref="messagesBox">
        <div
          v-for="m in messages"
          :key="m.id"
          :class="['chat-message', m.from === 'me' ? 'me' : 'them']"
        >
          <div class="bubble">{{ m.text }}</div>
          <div class="time">{{ formatTime(m.ts) }}</div>
        </div>
      </div>

      <form class="chat-input" @submit.prevent="send">
        <input v-model="draft" type="text" placeholder="Écrire un message..." />
        <button :disabled="!draft.trim()">➤</button>
      </form>
    </div>
  </transition>
</template>

<script setup>
import phrase from '@/assets/phrase.json'

import { ref, nextTick } from 'vue'

const open = ref(false)
const draft = ref('')

const startPhrase = phrase.filter((startPhrase) => startPhrase.type.includes('start'))

const messages = ref([
  {
    id: 1,
    text: startPhrase[Math.floor(Math.random() * startPhrase.length)].message,
    from: 'them',
    ts: Date.now(),
  },
])

const messagesBox = ref(null)

function scrollToBottom() {
  nextTick(() => {
    const el = messagesBox.value
    if (el) el.scrollTop = el.scrollHeight
  })
}

function send() {
  if (!draft.value.trim()) return
  messages.value.push({
    id: Date.now(),
    text: draft.value,
    from: 'me',
    ts: Date.now(),
  })
  draft.value = ''
  scrollToBottom()
}

function connectToGpt() {}

function interuptPlayer() {
  open.value = true
  const interruptPhrase = phrase.filter((startPhrase) => startPhrase.type.includes('interrupt'))
  messages.push({
    id: 1,
    text: interruptPhrase[Math.floor(Math.random() * interruptPhrase.length)].message,
    from: 'them',
    ts: Date.now(),
  })
}

function formatTime(ts) {
  return new Date(ts).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
}

scrollToBottom()
</script>

<style scoped>
/* Floating button */
.chat-button {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background: #a2e436;
  color: white;
  font-size: 22px;
  border-radius: 50%;
  border: none;
  width: 56px;
  height: 56px;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.2);
}

/* Popup container */
.chat-container {
  position: fixed;
  bottom: 90px;
  right: 20px;
  width: 320px;
  height: 420px;
  background: white;
  border-radius: 14px;
  display: flex;
  flex-direction: column;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
  overflow: hidden;
}

/* Header */
.chat-header {
  background: #a2e436;
  color: white;
  padding: 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.close-btn {
  background: transparent;
  border: none;
  color: white;
  font-size: 20px;
  cursor: pointer;
}

/* Messages */
.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 12px;
}
.chat-message {
  margin-bottom: 10px;
  max-width: 75%;
}
.chat-message.me {
  margin-left: auto;
  text-align: right;
}
.bubble {
  padding: 8px 12px;
  border-radius: 12px;
}
.me .bubble {
  background: #d1e7ff;
}
.them .bubble {
  background: #f1f1f1;
}
.time {
  font-size: 10px;
  opacity: 0.6;
  margin-top: 2px;
}

/* Input */
.chat-input {
  display: flex;
  padding: 10px;
  gap: 8px;
  border-top: 1px solid #eee;
}
.chat-input input {
  flex: 1;
  padding: 8px;
  border-radius: 8px;
  border: 1px solid #ccc;
}
.chat-input button {
  background: #a2e436;
  color: white;
  border: none;
  padding: 0 12px;
  border-radius: 8px;
  cursor: pointer;
}

/* Fade animation */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.25s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
