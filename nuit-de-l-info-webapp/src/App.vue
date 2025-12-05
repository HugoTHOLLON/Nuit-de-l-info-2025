<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import Chatbot from './components/chat/Chatbot.vue'
</script>

<template>
  <header>
    <!-- TODO Change data-bs-theme="dark" to light depending on the bootswatch theme -->
    <nav class="navbar navbar-expand-sm fixed-top bg-gradient-primary">
      <div class="container-fluid">
        <RouterLink to="/" class="navbar-brand">
          <img alt="Vue logo" class="logo" src="@/assets/logo_nird.png" height="60" />
        </RouterLink>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarElements"
          aria-controls="navbarElements"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarElements">
          <ul class="navbar-nav me-auto gap-1">
            <li class="nav-item">
              <RouterLink to="/" class="nav-link" active-class="active">Accueil</RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink to="/about" class="nav-link" active-class="active">À propos</RouterLink>
            </li>
            <li>
              <RouterLink to="/login" class="nav-link" active-class="active">Jeu</RouterLink>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </header>

  <main class="min-vh-100">
    <RouterView />
  </main>

  <footer class="container-fluid bg-dark d-flex flex-column align-items-center py-5 text-light">
    Tout libre de droit
  </footer>
  <Chatbot />
</template>

<style>
.nav-link.active {
  font-weight: bold;
}

.nav-link:not(.active) {
  opacity: 0.6;
}

.navbar-collapse.show .nav-item {
  margin-left: 20px;
}

main {
  padding: 30px;
  padding-top: 150px;
}
</style>
