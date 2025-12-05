<script setup lang="ts">
import { Input } from './Inputs'
import { ref } from 'vue'
import NesController from './NesController.vue'

const no = Input.Nothing
const inputs = ref<Array<Input>>([no, no, no, no, no, no, no, no, no, no, no])
const currentInputIndex = ref(0)

function addInput(input: Input) {
  if (input == Input.Select) {
    clearArray()
    return
  }

  inputs.value[currentInputIndex.value] = input
  currentInputIndex.value++

  if (currentInputIndex.value > 10) {
    if (codeValid()) {
      // TODO redirection
    } else {
      clearArray()
    }
  }
}

function clearArray() {
  currentInputIndex.value = 0
  for (let i = 0; i < inputs.value.length; i++) {
    inputs.value[i] = Input.Nothing
  }
}

function codeValid(): Boolean {
  const answer = [
    Input.ArrowUp,
    Input.ArrowUp,
    Input.ArrowDown,
    Input.ArrowDown,
    Input.ArrowLeft,
    Input.ArrowRight,
    Input.ArrowLeft,
    Input.ArrowRight,
    Input.ButtonB,
    Input.ButtonA,
    Input.Start,
  ]

  for (let i = 0; i < inputs.value.length; i++) {
    if (inputs.value[i] != answer[i]) {
      return false
    }
  }
  return true
}
</script>

<template>
  <div class="d-flex align-items-center flex-column gap-3">
    <NesController @input-pressed="addInput" />
    <ul class="input-list">
      <li v-for="i in inputs" class="input">{{ i }}</li>
    </ul>
  </div>
</template>

<style scoped>
.input-list {
  display: flex;
  justify-content: space-between;
  width: 100%;
  max-width: 700px;
  border-radius: 10px;
  border: 10px black solid;
  list-style: none;
  padding: 30px;
}

.input {
  text-decoration: none;
  margin: 0;
  padding: 0;
  font-size: 1.8rem;
}
</style>
