---
layout: splash
---

<style>
  /* Grey background for the entire landing page */
  body {
    background-color: #e5e5e5;
  }

  .home-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 85vh;
  }

  .home-name {
    font-size: 3rem;
    margin-bottom: 3rem;
    font-weight: bold;
    color: #333;
    text-align: center;
  }

  .square-grid {
    display: flex;
    gap: 2rem;
    flex-wrap: wrap;
    justify-content: center;
  }

  .square-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 200px;
    height: 200px;
    background-color: #ffffff;
    color: #333 !important;
    text-decoration: none;
    font-size: 1.5rem;
    font-weight: bold;
    border-radius: 0;
  }
</style>

<div class="home-wrapper">
  <h1 class="home-name">luca göcke</h1>

  <div class="square-grid">
    <a href="/music/" class="square-link">music</a>
    <a href="/cv/" class="square-link">cv</a>
    <a href="/writing/" class="square-link">writing</a>
  </div>
</div>
