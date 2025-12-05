<!-- MERCI CHAT -->

<template>
  <!-- Button -->
  <button class="chat-button bg-gradient-secondary" @click="open = !open">💬</button>

  <!-- Popup -->
  <transition name="fade">
    <div v-if="open" class="card chat-bot">
      <div class="card-header chat-header bg-gradient-secondary fw-bold">
        <span>Charistote de Vivaris</span>
        <button class="close-btn" @click="open = false">×</button>
      </div>

      <div class="chat-messages" ref="messagesBox">
        <div
          v-for="m in messages"
          :key="m.id"
          :class="['chat-message', m.from === 'me' ? 'me' : 'them']"
        >
          <div class="bubble">
            <template v-if="m.text === '...'">
              <span class="typing"><span></span><span></span><span></span></span>
            </template>
            <template v-else-if="m.from === 'them'">
              <div v-html="renderMarkdown(m.text)"></div>
            </template>
            <template v-else>
              {{ m.text }}
            </template>
          </div>
          <div class="time">{{ formatTime(m.ts) }}</div>
        </div>
      </div>

      <form class="chat-input" @submit.prevent="send">
        <input v-model="draft" type="text" placeholder="Écrire un message..." />
        <button :disabled="!draft.trim()" class="btn btn-secondary text-light">➤</button>
      </form>
    </div>
  </transition>
</template>

<script setup lang="ts">
import phrase from '@/assets/phrase.json'

import { ref, nextTick } from 'vue'
import { marked } from 'marked'

type Phrase = {
  type: string
  message: string
}

type Message = {
  id: number
  text: string
  from: 'me' | 'them'
  ts: number
}

const loading = ref(false)

const phrases = phrase as Phrase[]

const open = ref<boolean>(false)
const draft = ref<string>('')

const answer = ref<string | null>(null)

const startPhrases = phrases.filter((p) => p.type.includes('start'))

function randomMessageFrom(list: Phrase[], fallback = '...'): string {
  if (!list || list.length === 0) return fallback
  const idx = Math.floor(Math.random() * list.length)
  return list[idx]?.message ?? fallback
}

function renderMarkdown(text: string) {
  return marked.parse(text)
}

const messages = ref<Message[]>([
  {
    id: Date.now(),
    text: randomMessageFrom(startPhrases, 'Bonjour !'),
    from: 'them',
    ts: Date.now(),
  },
])

const messagesBox = ref<HTMLElement | null>(null)

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
  const textToSend = draft.value
  draft.value = ''

  const loadingMessage: Message = {
    id: Date.now() + 1,
    text: '...',
    from: 'them',
    ts: Date.now(),
  }
  messages.value.push(loadingMessage)
  scrollToBottom()

  loading.value = true
  ask(draft.value, loadingMessage.id)
}

async function ask(message: string, loadingId: number) {
  const response = await fetch('https://chat.endide.com/api/chat/completions', {
    method: 'POST',
    headers: {
      Authorization:
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjA3OWU3MDg4LWJjY2EtNDExNy1hOWE0LWYzY2Q1ODU4MGFlZSIsImV4cCI6MTc2NzMwNzQwOH0.QP_SwZo37i5P2KaqElyzfbE1UQ3DcXXjNBRmSs9lx-I',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'nuitinfo',
      messages: [
        {
          role: 'user',
          content: message,
        },
      ],
    }),
  })

  const data = await response.json()
  const text = data?.choices?.[0]?.message?.content ?? 'Aucune réponse'

  const idx = messages.value.findIndex((m) => m.id === loadingId)
  const loadingMsg = messages.value[idx]
  if (loadingMsg) {
    loadingMsg.text = text
  }

  loading.value = false
}

function interruptPlayer() {
  open.value = true
  const interruptPhrases = phrases.filter((p) => p.type.includes('interrupt'))
  messages.value.push({
    id: Date.now(),
    text: randomMessageFrom(interruptPhrases, '...'),
    from: 'them',
    ts: Date.now(),
  })
  scrollToBottom()
}

function formatTime(ts: number): string {
  return new Date(ts).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
}
</script>
<style scoped>
/* Floating button */
.chat-button {
  position: fixed;
  bottom: 20px;
  right: 20px;
  font-size: 22px;
  border-radius: 50%;
  border: none;
  width: 56px;
  height: 56px;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.2);
}

.typing {
  display: inline-block;
  width: 20px;
}

.typing span {
  display: inline-block;
  width: 4px;
  height: 4px;
  margin: 0 1px;
  background: #888;
  border-radius: 50%;
  animation: blink 1s infinite;
}

.typing span:nth-child(2) {
  animation-delay: 0.2s;
}
.typing span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes blink {
  0%,
  80%,
  100% {
    opacity: 0;
  }
  40% {
    opacity: 1;
  }
}

/* Popup container */
.chat-bot {
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
  padding: 12px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.close-btn {
  background: transparent;
  border: none;
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
