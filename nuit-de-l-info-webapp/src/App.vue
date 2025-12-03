<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <header>
    <!-- TODO Change data-bs-theme="dark" to light depending on the bootswatch theme -->
    <nav class="navbar navbar-expand-sm fixed-top bg-primary" data-bs-theme="light">
      <div class="container-fluid">
        <RouterLink to="/" class="navbar-brand">
          <img alt="Vue logo" class="logo" src="@/assets/logo.png" width="60" height="60" />
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
              <RouterLink to="/" class="nav-link" active-class="active">Home</RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink to="/about" class="nav-link" active-class="active">About</RouterLink>
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
    &copy; Some random copyright
  </footer>
</template>

<style>
.nav-link.active {
  background-color: rgba(255, 255, 255, 0.3);
  border-radius: 0.25rem;
}

main {
  padding: 30px;
  padding-top: 150px;
}
</style>
