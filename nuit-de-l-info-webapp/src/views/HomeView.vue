<script setup lang="ts"></script>

<template>
  <div class="row g-3">
    <div class="col-sm-8 d-flex flex-column gap-3">
      <div class="card">
        <div class="card-header bg-gradient-primary fw-bold">Synopsis</div>
        <div class="card-body">
          Vous êtes le directeur/la directrice d'un collège de campagne, l'un de vos enseignants
          vous solicites, il a entendu parler d'une initiative du corps enseignant français : La
          démarche NIRD, Numérique Inclusif Responsable Durable. Intrigué par le projet, vous êtes
          convaincus que c'est une excellente initiative et vous suivez le projet. Votre objectif
          actuel est donc de pousser cette transition. A l'aide des subventions de l'état, vous
          devez gérer votre école pour prouver l'intérêt de la démarche NIRD et augmenter vos
          financement afin d'offrir une meilleure éducation aux élèves ainsi qu'un meilleur
          environnement de travail pour les professeurs.
        </div>
      </div>

      <div class="card">
        <div class="card-header bg-gradient-primary fw-bold">Règles</div>
        <div class="card-body">
          Managez votre école, gérez vos finances et accomplissez la transition suggérée par la
          démarche NIRD. Faites attention, si la qualité de l'enseignement diminue trop, vous
          risquez de perdre votre place et de décrédibiliser la démarche auprès de votre région. Si
          vous parvenez à vous débarasser de Windows, à atteindre une moyenne de 95% d'engagement
          des élèves et de participations des professeurs, félicitations, vous avez accompli la
          transition avec succès et votre école sert désormais d'exemple pour convaincre les
          établissements encore frilleux à l'idée de suivre les mêmes traces que vous.
        </div>
      </div>
    </div>
    <div class="col-sm-4">
      <div class="card h-100">
        <div class="card-header bg-gradient-secondary fw-bold">A propos de nous</div>
        <div class="card-body">
          La démarche NIRD vise à promouvoir l'indépendence et la responsabilité numérique scolaire.
          C'est une initiative venant "d'en bas", et qui vise à convaincre "plus haut" de sa
          pertinence. Il s'agit d'augmenter la durée de vie du matériel informatique, de se rendre
          indépendent des entreprise big tech et d'inculquer de bonnes habitudes aux étudiants tout
          en dégageant des fonds qui peuvent être investis dans une meilleure qualité de
          l'éducation. Ici, vous pourrez jouer à un mini jeu pour comprendre de manière ludique les
          objectifs et intérêts de cette démarche. N'hésitez pas à visiter l'onglet "Nous rejoindre"
          pour accéder à nos forums, vous informer plus en détails et savoir comment VOUS pouvez
          agir pour intégrer votre école à la démarche NIRD.
        </div>
      </div>
    </div>
  </div>
  <div class="container-fluid justify-content-center d-flex button-holder">
    <!-- <button type="button" class="btn bg-gradient-primary text-light fw-bold">Just Btn</button>
    <button type="button" class="btn btn-primary">Primary</button>
    <button type="button" class="btn btn-secondary">Secondary</button> -->
    <button type="button" class="btn btn-success btn-lg" id="play">Jouer !</button>
    <!-- <button type="button" class="btn btn-info">Info</button>
    <button type="button" class="btn btn-warning">Warning</button>
    <button type="button" class="btn btn-danger">Danger</button>
    <button type="button" class="btn btn-light">Light</button>
    <button type="button" class="btn btn-dark">Dark</button>
    <button type="button" class="btn btn-link">Link</button> -->
  </div>
</template>

<style scoped>
.button-holder {
  margin: 15px;
}

button#play {
  font-size: 2rem;
}

.card-header {
  font-size: 1.2rem;
}
</style>
