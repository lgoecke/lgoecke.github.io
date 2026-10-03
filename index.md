---
layout: splash
---

<style>
  body {
    background-color: #f5f5f5; /* Softer, more refined grey */
    font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", Helvetica, Arial, sans-serif;
  }

  .home-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 85vh;
  }

  .home-name {
    font-size: 1.2rem; /* Smaller, understated heading */
    margin-bottom: 4rem;
    font-weight: 400;
    letter-spacing: 0.15em; /* Wide tracking */
    color: #111;
    text-align: center;
    text-transform: lowercase;
  }

  .square-grid {
    display: flex;
    gap: 1.5rem; /* Tighter gap */
    flex-wrap: wrap;
    justify-content: center;
  }

  .square-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 140px; /* Reduced scale to prevent bulkiness */
    height: 140px;
    background-color: #ffffff;
    color: #111 !important;
    text-decoration: none;
    font-size: 0.85rem; /* Smaller typography inside the box */
    font-weight: 400;
    letter-spacing: 0.1em;
    border: 1px solid #eaeaea; /* Crisp, subtle border */
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
