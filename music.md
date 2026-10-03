---
layout: single
title: "luca göcke music"
permalink: /music/
---

<style>
  .song-list {
    list-style-type: none;
    padding: 0;
  }
  .song-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 1rem;
    min-height: 54px; /* Prevents vertical jumping when player appears */
  }
  .song-title {
    cursor: pointer;
    font-size: 1.25rem;
    font-weight: bold;
    transition: color 0.1s;
  }
  .song-title:hover {
    text-decoration: underline;
  }
  .song-player {
    display: none; /* Hidden by default */
    height: 40px;
  }
  .song-player.active {
    display: block; /* Revealed when clicked */
  }
</style>

<ul class="song-list">
  <li class="song-item">
    <span class="song-title">sign 1</span>
    <audio class="song-player" controls preload="none">
      <source src="/assets/audio/sign1.mp3" type="audio/mpeg">
    </audio>
  </li>
  <li class="song-item">
    <span class="song-title">sign 2</span>
    <audio class="song-player" controls preload="none">
      <source src="/assets/audio/sign2.mp3" type="audio/mpeg">
    </audio>
  </li>
  <li class="song-item">
    <span class="song-title">sign 3</span>
    <audio class="song-player" controls preload="none">
      <source src="/assets/audio/sign3.mp3" type="audio/mpeg">
    </audio>
</ul>

<script>
  const items = document.querySelectorAll('.song-item');
  let currentAudio = null;

  items.forEach(item => {
    const title = item.querySelector('.song-title');
    const player = item.querySelector('.song-player');

    title.addEventListener('click', () => {
      // Ignore click if the player is already active
      if (currentAudio === player) return;

      // Stop playback and hide the previously active player
      if (currentAudio) {
        currentAudio.pause();
        currentAudio.currentTime = 0;
        currentAudio.classList.remove('active');
      }

      // Reveal the new player and start playback
      player.classList.add('active');
      player.play();
      currentAudio = player;
    });
  });
</script>
