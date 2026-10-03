---
layout: single
title: "luca göcke"
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
    margin-bottom: 0.5rem;
    min-height: 40px;
    gap: 1.5rem;
  }

  .song-title {
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 400; /* Removed bold */
    letter-spacing: 0.02em;
    transition: color 0.2s ease;
    color: #111;
  }

  .song-title:hover {
    color: #888;
  }

  .custom-player {
    display: none;
    align-items: center;
    gap: 1rem;
    flex-grow: 1;
    max-width: 300px;
    opacity: 0;
    transition: opacity 0.3s ease; /* Fade-in effect */
  }

  .custom-player.active {
    display: flex;
    opacity: 1;
  }

  .play-toggle {
    background: none;
    border: none;
    padding: 0;
    font-size: 0.85rem;
    font-family: monospace;
    cursor: pointer;
    color: #111;
    width: 45px; /* Fixed width prevents layout shift */
    text-align: left;
  }

  .progress-bar {
    -webkit-appearance: none;
    appearance: none;
    flex-grow: 1;
    height: 1px;
    background: #d1d1d1;
    cursor: pointer;
    outline: none;
  }

  .progress-bar::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 4px;
    height: 4px;
    border-radius: 0; /* Square instead of circle */
    background: #111;
  }

  .progress-bar::-moz-range-thumb {
    width: 4px;
    height: 4px;
    border-radius: 0;
    background: #111;
    border: none;
  }

  .time-display {
    font-size: 0.8rem;
    color: #999;
    font-family: monospace;
  }

  .download-btn {
    font-size: 0.8rem;
    color: #999;
    text-decoration: none;
    transition: color 0.2s ease;
  }

  .download-btn:hover {
    color: #111;
  }
</style>

<ul class="song-list">
  <li class="song-item">
    <span class="song-title">sign 1</span>
    <div class="custom-player">
      <button class="play-toggle">play</button>
      <input type="range" class="progress-bar" value="0" max="100">
      <span class="time-display">0:00</span>
      <a href="/assets/audio/sign1.mp3" download class="download-btn">↓</a>
    </div>
    <audio preload="none">
      <source src="/assets/audio/sign1.mp3" type="audio/mpeg">
    </audio>
  </li>

  <li class="song-item">
    <span class="song-title">sign 2</span>
    <div class="custom-player">
      <button class="play-toggle">play</button>
      <input type="range" class="progress-bar" value="0" max="100">
      <span class="time-display">0:00</span>
      <a href="/assets/audio/sign1.mp3" download class="download-btn">↓</a>
    </div>
    <audio preload="none">
      <source src="/assets/audio/sign2.mp3" type="audio/mpeg">
    </audio>
  </li>

  <li class="song-item">
    <span class="song-title">sign 3</span>
    <div class="custom-player">
      <button class="play-toggle">play</button>
      <input type="range" class="progress-bar" value="0" max="100">
      <span class="time-display">0:00</span>
      <a href="/assets/audio/sign1.mp3" download class="download-btn">↓</a>
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

    title.addEventListener('click', () => {
      if (activeItem && activeItem !== item) {
        const oldAudio = activeItem.querySelector('audio');
        oldAudio.pause();
        oldAudio.currentTime = 0;
        const oldUI = activeItem.querySelector('.custom-player');
        oldUI.classList.remove('active');
        activeItem.querySelector('.play-toggle').textContent = 'play';
      }

      // Small delay allows display:flex to apply before setting opacity
      playerUI.style.display = 'flex';
      setTimeout(() => playerUI.classList.add('active'), 10);

      if (audio.paused) {
        audio.play();
        toggleBtn.textContent = 'pause';
      } else {
        audio.pause();
        toggleBtn.textContent = 'play';
      }
      activeItem = item;
    });

    toggleBtn.addEventListener('click', () => {
      if (audio.paused) {
        audio.play();
        toggleBtn.textContent = 'pause';
      } else {
        audio.pause();
        toggleBtn.textContent = 'play';
      }
    });

    audio.addEventListener('timeupdate', () => {
      const percent = (audio.currentTime / audio.duration) * 100;
      progressBar.value = percent || 0;
      timeDisplay.textContent = formatTime(audio.currentTime);
    });

    progressBar.addEventListener('input', (e) => {
      const seekTime = (e.target.value / 100) * audio.duration;
      audio.currentTime = seekTime;
    });

    audio.addEventListener('ended', () => {
      toggleBtn.textContent = 'play';
      progressBar.value = 0;
      timeDisplay.textContent = "0:00";
    });
  });
</script>
