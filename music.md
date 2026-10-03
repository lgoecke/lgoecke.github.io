---
layout: single
title: "luca göcke"
permalink: /music/
---

<style>

/* Album Header */
  .album-header {
    display: flex;
    align-items: flex-end; /* Aligns the text to the bottom of the image */
    gap: 2rem;
    margin-top: 5rem; /* Generous breathing room */
    margin-bottom: 2.5rem;
    min-height: 140px; /* Reserves space so the page doesn't jump */
  }

  .album-title {
    font-size: 1rem;
    font-weight: 400;
    letter-spacing: 0.15em;
    color: #999;
    text-transform: lowercase;
    margin: 0;
    padding-bottom: 4px; /* Optical alignment with the image baseline */
  }

  .album-cover {
    width: 140px;
    height: 140px;
    object-fit: cover;
    opacity: 0;
    transform: translateY(10px); /* Starts slightly lower */
    transition: opacity 0.6s ease, transform 0.6s cubic-bezier(0.25, 1, 0.5, 1);
    pointer-events: none;
    box-shadow: 0 8px 24px rgba(0,0,0,0.06); /* Very soft gallery shadow */
  }

  .album-cover.active {
    opacity: 1;
    transform: translateY(0); /* Glides into place */
    pointer-events: auto;
  }
  /* Track Styles */
  .song-list {
    list-style-type: none;
    padding: 0;
  }

  .song-item {
    display: flex;
    flex-direction: column;
    margin-bottom: 0.75rem;
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

{% for group in site.data.albums %}
  <div class="album-section">

   {% if group.title and group.title != "" %}
      <!-- Use the cover variable if it exists, otherwise use the title with removed spaces -->
      {% if group.cover %}
        {% assign album_filename = group.cover %}
      {% else %}
        {% assign album_filename = group.title | remove: " " %}
      {% endif %}

      <div class="album-header">
        <h2 class="album-title">{{ group.title }}</h2>
        <img src="/assets/audio/{{ album_filename }}.jpg" class="album-cover" onerror="this.setAttribute('data-error', 'true'); this.style.display='none';">
      </div>
    {% else %}
      <!-- Adds spacing so un-albumed tracks don't merge into the album above -->
      <div style="margin-top: 3rem;"></div>
    {% endif %}

    <ul class="song-list">
      {% for track in group.tracks %}

        <!-- Check if the track is an object with a specific file, or just a string -->
        {% if track.title %}
          {% assign track_title = track.title %}
          {% assign filename = track.file %}
        {% else %}
          {% assign track_title = track %}
          {% assign filename = track | remove: " " %}
        {% endif %}

        <li class="song-item">
          <span class="song-title">{{ track_title }}</span>
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
  </div>
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
      const albumSection = item.closest('.album-section');
      const albumCover = albumSection ? albumSection.querySelector('.album-cover') : null;

      if (activeItem && activeItem !== item) {
        const oldAudio = activeItem.querySelector('audio');
        oldAudio.pause();
        oldAudio.currentTime = 0;
        const oldDetails = activeItem.querySelector('.song-details');
        oldDetails.style.display = 'none';
        oldDetails.classList.remove('active');
        activeItem.querySelector('.play-toggle').textContent = 'play';

        // Hide the old album cover smoothly via CSS class
        const oldAlbumSection = activeItem.closest('.album-section');
        const oldAlbumCover = oldAlbumSection ? oldAlbumSection.querySelector('.album-cover') : null;

        if (oldAlbumCover && oldAlbumCover !== albumCover) {
          oldAlbumCover.classList.remove('active');
        }
      }

      songDetails.style.display = 'flex';
      setTimeout(() => songDetails.classList.add('active'), 10);

      // Show the new album cover smoothly via CSS class
      if (albumCover && !albumCover.getAttribute('data-error')) {
        albumCover.classList.add('active');
      }

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
