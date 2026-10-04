---
layout: single
title: "luca göcke"
permalink: /cv/
---

<style>
  /* Section Spacing */
  .cv-section {
    margin-top: 4rem;
    margin-bottom: 2rem;
  }

  /* Chic Lowercase Headers (Matches your album titles) */
  .cv-header {
    font-size: 0.9rem;
    font-weight: bold;
    letter-spacing: 0.15em;
    color: #999;
    text-transform: lowercase;
    margin-bottom: 2rem;
    border-bottom: 1px solid #e5e5e5;
    padding-bottom: 0.5rem;
  }

  /* Editorial Two-Column Grid */
  .cv-item {
    display: flex;
    flex-direction: row;
    align-items: baseline;
    margin-bottom: 1.5rem;
  }

  /* Monospace Dates (Matches your audio player) */
  .cv-dates {
    flex: 0 0 140px; /* Fixed width for the left column */
    font-family: monospace;
    font-size: 0.85rem;
    color: #999;
    letter-spacing: -0.02em;
  }

  /* Content Column */
  .cv-content {
    flex-grow: 1;
    max-width: 600px; /* Keeps line lengths comfortable for reading */
  }

  .cv-title {
    font-size: 1.05rem;
    font-weight: 500;
    color: #111;
    margin: 0 0 0.2rem 0;
  }

  .cv-institution {
    font-size: 0.9rem;
    color: #888;
    margin: 0 0 0.5rem 0;
  }

  .cv-desc {
    font-size: 0.85rem;
    line-height: 1.6;
    color: #666;
    margin: 0;
  }

  /* Skills Specific Formatting */
  .cv-skill-row {
    display: flex;
    margin-bottom: 0.8rem;
    font-size: 0.9rem;
  }

  .cv-skill-category {
    flex: 0 0 140px;
    color: #999;
    font-weight: 500;
  }

  .cv-skill-items {
    color: #111;
  }

  /* Mobile Responsiveness */
  @media (max-width: 600px) {
    .cv-item {
      flex-direction: column;
    }
    .cv-dates {
      margin-bottom: 0.3rem;
      flex: auto;
    }
    .cv-skill-row {
      flex-direction: column;
      margin-bottom: 1.2rem;
    }
    .cv-skill-category {
      margin-bottom: 0.2rem;
    }
  }
</style>

<div class="cv-section">
  <h2 class="cv-header">experience</h2>
  {% for job in site.data.cv.experience %}
    <div class="cv-item">
      <div class="cv-dates">{{ job.dates }}</div>
      <div class="cv-content">
        <h3 class="cv-title">{{ job.title }}</h3>
        <p class="cv-institution">{{ job.institution }}</p>
        {% if job.description %}
          <p class="cv-desc">{{ job.description }}</p>
        {% endif %}
      </div>
    </div>
  {% endfor %}
</div>

<div class="cv-section">
  <h2 class="cv-header">education</h2>
  {% for degree in site.data.cv.education %}
    <div class="cv-item">
      <div class="cv-dates">{{ degree.dates }}</div>
      <div class="cv-content">
        <h3 class="cv-title">{{ degree.title }}</h3>
        <p class="cv-institution">{{ degree.institution }}</p>
        {% if degree.description %}
          <p class="cv-desc">{{ degree.description }}</p>
        {% endif %}
      </div>
    </div>
  {% endfor %}
</div>

<div class="cv-section">
  <h2 class="cv-header">capabilities</h2>
  {% for skill in site.data.cv.skills %}
    <div class="cv-skill-row">
      <div class="cv-skill-category">{{ skill.category }}</div>
      <div class="cv-skill-items">{{ skill.items }}</div>
    </div>
  {% endfor %}
</div>
