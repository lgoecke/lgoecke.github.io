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
    margin-bottom: 1.5rem;
    min-height: 40px;
    gap: 1.5rem; /* Controls the exact distance between name and player */
  }

  .song-title {
    cursor: pointer;
    font-size: 1.25rem;
    font-weight: bold;
    transition: color 0.1s;
    /* Removed min-width to prevent large gaps */
  }

  .song-title:hover {
    color: #666;
  }

  /* Minimal Player UI */
  .custom-player {
    display: none;
    align-items: center;
    gap: 1rem;
    flex-grow: 1;
    max-width: 300px;
  }

  .custom-player.active {
    display: flex;
  }

  .play-toggle {
    background: none;
    border: none;
    padding: 0;
    font-size: 0.9rem;
    font-weight: bold;
    cursor: pointer;
    color: #111;
    width: 20px;
    text-align: left;
    line-height: 1; /* Removes default text bounding box padding */
    transform: translateY(-1px); /* Nudges the icon up to align perfectly with the 1px bar */
  }
  .progress-bar {
    -webkit-appearance: none;
    appearance: none;
    flex-grow: 1;
    height: 1px;
    background: #ccc;
    cursor: pointer;
    outline: none;
  }

  /* Scrubber dot */
  .progress-bar::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #111;
  }
  .progress-bar::-moz-range-thumb {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #111;
    border: none;
  }

  .time-display {
    font-size: 0.85rem;
    color: #888;
    font-family: monospace;
  }
</style>

<ul class="song-list">
  <li class="song-item">
    <span class="song-title">sign 1</span>
    <div class="custom-player">
      <button class="play-toggle">||</button>
      <input type="range" class="progress-bar" value="0" max="100">
      <span class="time-display">0:00</span>
    </div>
    <audio preload="none">
      <source src="/assets/audio/sign1.mp3" type="audio/mpeg">
    </audio>
  </li>

  <li class="song-item">
    <span class="song-title">sign 2</span>
    <div class="custom-player">
      <button class="play-toggle">||</button>
      <input type="range" class="progress-bar" value="0" max="100">
      <span class="time-display">0:00</span>
    </div>
    <audio preload="none">
      <source src="/assets/audio/sign2.mp3" type="audio/mpeg">
    </audio>
  </li>

  <li class="song-item">
    <span class="song-title">sign 3</span>
    <div class="custom-player">
      <button class="play-toggle">||</button>
      <input type="range" class="progress-bar" value="0" max="100">
      <span class="time-display">0:00</span>
    </div>
    <audio preload="none">
      <source src="/assets/audio/sign3.mp3" type="audio/mpeg">
    </audio>
  </li>
</ul>
<script>
  const formatTime = (seconds) => {
    if (isNaN(seconds)) return "0:00";
    const m = Math.floor(seconds / 60);
    const s = Math.floor(seconds % 60);
    return `${m}:${s < 10 ? '0' : ''}${s}`;
  };

  const items = document.querySelectorAll('.song-item');
  let activeItem = null;

  items.forEach(item => {
    const title = item.querySelector('.song-title');
    const playerUI = item.querySelector('.custom-player');
    const audio = item.querySelector('audio');
    const toggleBtn = item.querySelector('.play-toggle');
    const progressBar = item.querySelector('.progress-bar');
    const timeDisplay = item.querySelector('.time-display');

    // Play/Pause via Title Click
    title.addEventListener('click', () => {
      if (activeItem && activeItem !== item) {
        const oldAudio = activeItem.querySelector('audio');
        oldAudio.pause();
        oldAudio.currentTime = 0;
        activeItem.querySelector('.custom-player').classList.remove('active');
      }

      playerUI.classList.add('active');

      if (audio.paused) {
        audio.play();
        toggleBtn.textContent = '||';
      } else {
        audio.pause();
        toggleBtn.textContent = '>';
      }
      activeItem = item;
    });

    // Play/Pause via Button
    toggleBtn.addEventListener('click', () => {
      if (audio.paused) {
        audio.play();
        toggleBtn.textContent = '||';
      } else {
        audio.pause();
        toggleBtn.textContent = '>';
      }
    });

    // Update progress bar and time display as song plays
    audio.addEventListener('timeupdate', () => {
      const percent = (audio.currentTime / audio.duration) * 100;
      progressBar.value = percent || 0;
      timeDisplay.textContent = formatTime(audio.currentTime);
    });

    // Seek when dragging the progress bar
    progressBar.addEventListener('input', (e) => {
      const seekTime = (e.target.value / 100) * audio.duration;
      audio.currentTime = seekTime;
    });

    // Reset when song finishes
    audio.addEventListener('ended', () => {
      toggleBtn.textContent = '>';
      progressBar.value = 0;
      timeDisplay.textContent = "0:00";
    });
  });
</script>
