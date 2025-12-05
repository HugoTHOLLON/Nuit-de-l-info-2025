```vue
<template>
  <div id="snake-div">
    <p>Point : {{score}}</p>

    <canvas ref="canvas" id="snake" :width="width * cellSize" :height="height * cellSize"></canvas>
  </div>
</template>

<script setup lang="ts">
import { ref, defineProps, onMounted, onBeforeUnmount, h } from 'vue'

type Move = { x: number; y: number }
type Direction = { direction: string; keyCode: number; move: Move }
type Point = { x: number; y: number }

const props = defineProps<{ msg?: string }>()

const width = ref(45)
const height = ref(20)
const cellSize = ref(20)
const isPaused = ref(false)
let score = ref(0)

const canvas = ref<HTMLCanvasElement | null>(null)
const boardContext = ref<CanvasRenderingContext2D | null>(null)

const snake = ref<Point[]>([{ x: 0, y: 0 }])
const nextDirection = ref<Direction | null>(null)
const directions: Direction[] = [
  { direction: 'left', keyCode: 37, move: { x: -1, y: 0 } },
  { direction: 'top', keyCode: 38, move: { x: 0, y: -1 } },
  { direction: 'right', keyCode: 39, move: { x: 1, y: 0 } },
  { direction: 'bottom', keyCode: 40, move: { x: 0, y: 1 } },
]
const food = ref<Point | null>(null)

let interval: ReturnType<typeof setInterval> | null = null

function clear() {
  if (!boardContext.value) return
  boardContext.value.clearRect(0, 0, width.value * cellSize.value, height.value * cellSize.value)
}

function drawGrid() {
  if (!boardContext.value) return
  const ctx = boardContext.value
  
  ctx.strokeStyle = '#ddd'
  ctx.lineWidth = 1
  
  for (let x = 0; x <= width.value; x++) {
    ctx.beginPath()
    ctx.moveTo(x * cellSize.value, 0)
    ctx.lineTo(x * cellSize.value, height.value * cellSize.value)
    ctx.stroke()
  }
  
  for (let y = 0; y <= height.value; y++) {
    ctx.beginPath()
    ctx.moveTo(0, y * cellSize.value)
    ctx.lineTo(width.value * cellSize.value, y * cellSize.value)
    ctx.stroke()
  }
}


function drawGame() {
  if (!boardContext.value) return
  const ctx = boardContext.value
  clear()

  ctx.fillStyle = 'black'
  for (let i = 1; i < snake.value.length; i++) {
    const p = snake.value[i]
    if (!p) continue
    ctx.fillRect(p.x * cellSize.value, p.y * cellSize.value, cellSize.value, cellSize.value)
  }

  const head = snake.value[0]
  if (head) {
    ctx.fillStyle = 'green'
    ctx.fillRect(head.x * cellSize.value, head.y * cellSize.value, cellSize.value, cellSize.value)
  }

  if (food.value) {
    ctx.fillStyle = 'red'
    ctx.fillRect(food.value.x * cellSize.value, food.value.y * cellSize.value, cellSize.value, cellSize.value)
  }

  if (isPaused.value) {
    ctx.fillStyle = 'rgba(0,0,0,0.5)'
    ctx.fillRect(0, 0, width.value * cellSize.value, height.value * cellSize.value)
    ctx.fillStyle = 'white'
    const fontSize = Math.floor(cellSize.value * 1.5)
    ctx.font = `${fontSize}px sans-serif`
    const text = 'PAUSE'
    const metrics = ctx.measureText(text)
    const x = (width.value * cellSize.value - metrics.width) / 2
    const y = (height.value * cellSize.value) / 2 + fontSize / 2
    ctx.fillText(text, x, y)
  }
}

function resetGame() {
  isPaused.value = false
  snake.value = [{ x: Math.round(width.value / 2), y: Math.round(height.value / 2) }]
  moveFoodToFreePlace()
  score.value = 0
  drawGame()
}

function nextMove() {
  if (isPaused.value) {
    return
  }

  const dir = nextDirection.value
  if (!dir) return

  const head = snake.value[0]
  if (!head) return

  const newHead: Point = {
    x: head.x + dir.move.x,
    y: head.y + dir.move.y,
  }

  snake.value.unshift(newHead)

  if(newHead.x < 0  || newHead.x >= width.value || newHead.y < 0 || newHead.y >= height.value){
    resetGame()
    window.alert("Le serpent est mort");
    return
  }

  for (let i = 1; i < snake.value.length; i++) {
    const part = snake.value[i]
    if (!part) continue
    if (part.x === newHead.x && part.y === newHead.y) {
      resetGame()
      window.alert("Le serpent s'est mangé lui-même")
      return
    }
  }

  if (food.value && newHead.x === food.value.x && newHead.y === food.value.y) {
    moveFoodToFreePlace()
    score.value = score.value +1
  } else {
    snake.value.pop()
  }

  drawGame()
}

function togglePause() {
  isPaused.value = !isPaused.value
  drawGame()
}

function onKeyPress(event: KeyboardEvent) {
  const key = event.keyCode

  if (key === 27 || key === 32){
    togglePause()
    event.preventDefault()
    return
  }

  if(isPaused.value){
    return
  }

  const newDirection = directions.find(c => c.keyCode === key)
  if (!newDirection) return

  const current = nextDirection.value
  if (!current || Math.abs(newDirection.keyCode - current.keyCode) !== 2) {
    nextDirection.value = newDirection
  }
  event.preventDefault()
}

function moveFoodToFreePlace() {
  food.value = null
  while (food.value === null) {
    const x = Math.floor(Math.random() * width.value)
    const y = Math.floor(Math.random() * height.value)
    const snakePart = snake.value.find((s) => s.x === x && s.y === y)
    if (!snakePart) {
      food.value = { x, y }
    }
  }
}

onMounted(() => {
  if (canvas.value) {
    boardContext.value = canvas.value.getContext('2d')
  }
  if (!boardContext.value) {
    const el = document.getElementById('snake') as HTMLCanvasElement | null
    if (el) boardContext.value = el.getContext('2d')
  }

  window.addEventListener('keydown', onKeyPress)
  resetGame()
  interval = setInterval(nextMove, 200)
})

onBeforeUnmount(() => {
  if (interval) {
    clearInterval(interval)
    interval = null
  }
  window.removeEventListener('keydown', onKeyPress)
})
</script>

<style scoped>
#snake-div {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
}

#snake {
  border: 1px solid black;
}
</style>
