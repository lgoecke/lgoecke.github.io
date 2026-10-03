---
layout: single
title: "luca göcke"
permalink: /music/
---

<style>
  /* Album Typography */
  .album-title {
    font-size: 0.9rem;
    font-weight: bold;
    letter-spacing: 0.15em;
    margin-top: 3rem;
    margin-bottom: 1.5rem;
    color: #999;
    text-transform: lowercase;
  }

  /* Track Styles */
  .song-list {
    list-style-type: none;
    padding: 0;
  }

  .song-item {
    display: flex;
    flex-direction: column;
    margin-bottom: 1rem;
    min-height: 40px;
    justify-content: center;
  }

  .song-title {
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 400;
    letter-spacing: 0.02em;
    transition: color 0.2s ease;
    color: #111;
    display: inline-block;
  }

  .song-title:hover {
    color: #888;
  }

  .song-details {
    display: none;
    align-items: center;
    gap: 1.5rem;
    margin-top: 1rem;
    opacity: 0;
    transition: opacity 0.3s ease;
    width: 100%;
    max-width: 400px;
  }

  .song-details.active {
    display: flex;
    opacity: 1;
  }

  .cover-art {
    width: 60px;
    height: 60px;
    object-fit: cover;
    background-color: #f5f5f5;
  }

  .custom-player {
    display: flex;
    align-items: center;
    gap: 1rem;
    flex-grow: 1;
  }

  .play-toggle {
    background: none;
    border: none;
    padding: 0;
    font-size: 0.85rem;
    font-family: monospace;
    cursor: pointer;
    color: #111;
    width: 45px;
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
    border-radius: 0;
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

<!-- Loops through data/albums.yml -->
{% for album in site.data.albums %}
  <h2 class="album-title">{{ album.title }}</h2>
  <ul class="song-list">
    {% for track in album.tracks %}
      {% assign filename = track | remove: " " %}
      <li class="song-item">
        <span class="song-title">{{ track }}</span>
        <div class="song-details">
          <img src="/assets/audio/{{ filename }}.jpg" class="cover-art" onerror="this.style.display='none'">
          <div class="custom-player">
            <button class="play-toggle">play</button>
            <input type="range" class="progress-bar" value="0" max="100">
            <span class="time-display">0:00</span>
            <a href="/assets/audio/{{ filename }}.mp3" download class="download-btn">↓</a>
          </div>
        </div>
        <audio preload="none">
          <source src="/assets/audio/{{ filename }}.mp3" type="audio/mpeg">
        </audio>
      </li>
    {% endfor %}
  </ul>
{% endfor %}

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
    const songDetails = item.querySelector('.song-details');
    const audio = item.querySelector('audio');
    const toggleBtn = item.querySelector('.play-toggle');
    const progressBar = item.querySelector('.progress-bar');
    const timeDisplay = item.querySelector('.time-display');

    title.addEventListener('click', () => {
      if (activeItem && activeItem !== item) {
        const oldAudio = activeItem.querySelector('audio');
        oldAudio.pause();
        oldAudio.currentTime = 0;
        const oldDetails = activeItem.querySelector('.song-details');
        oldDetails.style.display = 'none';
        oldDetails.classList.remove('active');
        activeItem.querySelector('.play-toggle').textContent = 'play';
      }

      songDetails.style.display = 'flex';
      setTimeout(() => songDetails.classList.add('active'), 10);

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
