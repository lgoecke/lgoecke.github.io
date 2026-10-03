---
layout: splash
---

<style>
  /* Hide default Minimal Mistakes navigation and footer */
  .masthead, .page__footer {
    display: none !important;
  }

  /* Full-page centering container */
  .home-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 85vh;
  }

  /* Name typography */
  .home-name {
    font-size: 3rem;
    margin-bottom: 3rem;
    font-weight: bold;
    color: #333;
    text-align: center;
  }

  /* Responsive grid for squares */
  .square-grid {
    display: flex;
    gap: 2rem;
    flex-wrap: wrap;
    justify-content: center;
  }

  /* Square button styling */
  .square-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 200px;
    height: 200px;
    background-color: #f2f3f3;
    color: #333 !important;
    text-decoration: none;
    font-size: 1.5rem;
    font-weight: bold;
    border-radius: 8px;
    transition: transform 0.2s ease, background-color 0.2s ease;
  }

  .square-link:hover {
    background-color: #e2e4e4;
    transform: translateY(-5px);
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
