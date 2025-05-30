# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Jekyll-based personal blog/website for rogerkirkness.com. It contains 91+ blog posts spanning from 2012 to 2025, covering topics in philosophy, technology, business, science, education, politics, lifestyle, and futurism.

## Commands

### Local Development
```bash
# Install dependencies
bundle install

# Run Jekyll locally (serves on http://localhost:4000)
bundle exec jekyll serve

# Build the site
bundle exec jekyll build
```

### PDF Book Generation
```bash
# Generate a LaTeX-formatted book from blog posts
./scripts/preprocess.sh
```

## Architecture

### Core Structure
- **Jekyll Static Site Generator**: Transforms Markdown posts into HTML pages
- **GitHub Pages Deployment**: Site is deployed automatically via GitHub Pages to rogerkirkness.com
- **Progressive Web App**: Includes service worker (`sw.js`) for offline support and caching

### Content Organization
- **Posts** (`_posts/`): Blog posts in `YYYY-MM-DD-title.md` format with Jekyll front matter
- **Layouts**: `default.html` (base template) and `post.html` (individual posts)
- **Homepage** (`index.html`): Displays posts organized by tags in a card layout
- **Archive** (`archive.html`): Chronological list of all posts

### Key Features
1. **Service Worker Caching**: Pre-caches all posts for offline reading, uses NetworkFirst strategy for homepage and StaleWhileRevalidate for posts
2. **Tag-based Organization**: Posts are categorized by tags (Philosophy, Technology, Business, etc.) and displayed in grouped sections
3. **Book Generation**: The `scripts/preprocess.sh` script creates a LaTeX document from posts, organizing by tags and filtering posts with `book: false` front matter
4. **Responsive Design**: Mobile-first CSS with sticky navigation on desktop

### Post Front Matter Structure
```yaml
---
layout: post
title: "Post Title"
date: YYYY-MM-DD
tags: [Tag1, Tag2]
book: true  # Optional: false to exclude from book generation
---
```

## Development Notes
- The site uses minimal dependencies: Jekyll, jekyll-sitemap plugin, and kramdown-parser-gfm
- CSS is vanilla with no frameworks, embedded in layout files
- Navigation includes a Stripe payment link for book purchases
- All posts are cached by the service worker for offline access