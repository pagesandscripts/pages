# Quick Start Guide

## You Now Have a Reusable Template System! 🎉

### The Problem You Had
With 40 stories, if you wanted to change the design (add a share button, change the header, update footer), you'd need to manually edit 80 HTML files (40 English + 40 Persian). Not fun!

### The Solution
Now you have a **template-based system**:
- Edit design once in template files
- Run one command to update all 40 stories
- Takes seconds instead of hours

---

## How It Works

### 1. Your Content Lives Here
**File:** `stories-data.json`

All your stories are in ONE file with this structure:

```json
{
  "stories": [
    {
      "slug": "lady-prince",
      "en": {
        "title": "Lady Prince",
        "subtitle": "A fairy-tale vignette...",
        "genre": "Fantasy",
        "readingTime": "6 min",
        "content": "<p>Story text...</p>"
      },
      "fa": {
        "title": "شاهزاده خانم",
        "subtitle": "روایتی کوتاه...",
        "genre": "فانتزی",
        "readingTime": "۶ دقیقه",
        "content": "<p>متن داستان...</p>"
      }
    }
  ]
}
```

### 2. Your Design Lives Here
**Files:** `templates/story-en.html` and `templates/story-fa.html`

These template files control the design for ALL stories.

### 3. Generate Everything

```powershell
# Generate all story pages
.\tools\generate-stories.ps1

# Generate main index page
.\tools\generate-index.ps1
```

---

## Common Tasks

### Add a New Story

1. Open `stories-data.json`
2. Add your story to the array:
   ```json
   {
     "slug": "my-new-story",
     "en": { ... },
     "fa": { ... }
   }
   ```
3. Run:
   ```powershell
   .\tools\generate-stories.ps1
   .\tools\generate-index.ps1
   ```

Done! Your story appears on the site with proper navigation.

### Change Design for All Stories

**Example:** Add a share button to every story

1. Open `templates/story-en.html`
2. Add the share button HTML (e.g., in the footer):
   ```html
   <button class="share-button">Share</button>
   ```
3. Do the same in `templates/story-fa.html`
4. Run: `.\tools\generate-stories.ps1`

**Result:** All 40 stories now have the share button!

### Reorder Stories

1. In `stories-data.json`, move stories around in the array
2. Run both generators:
   ```powershell
   .\tools\generate-stories.ps1
   .\tools\generate-index.ps1
   ```

Navigation links update automatically.

### Change Story Content

1. Edit the story in `stories-data.json`
2. Run: `.\tools\generate-stories.ps1`

---

## Template Variables

When editing templates, you can use these placeholders:

- `{{TITLE}}` - Story title  
- `{{SUBTITLE}}` - Story description  
- `{{GENRE}}` - Genre  
- `{{READING_TIME}}` - Reading time  
- `{{SLUG}}` - URL slug (e.g., "lady-prince")  
- `{{CONTENT}}` - Full story HTML  
- `{{PREV_LINK}}` - Auto-generated previous link  
- `{{NEXT_LINK}}` - Auto-generated next link  
- `{{FA_TITLE}}` / `{{EN_TITLE}}` - Title in other language  

---

## Important Notes

### ✅ DO
- Edit `stories-data.json` for content changes
- Edit template files for design changes
- Run generators after making changes
- Keep `custom.css` files for story-specific styles

### ❌ DON'T
- Manually edit generated `index.html` files in story folders
- They'll be overwritten next time you run the generator

### Safe Files (Never Overwritten)
- `en/stories/*/custom.css` - Story-specific CSS
- `fa/stories/*/custom.css` - Story-specific CSS  
- `en/stories/*/images/*` - Story images
- `fa/stories/*/images/*` - Story images

---

## Example Workflow

**Scenario:** You want to add "Estimated reading: X min" to all story pages

1. **Edit template:**
   ```powershell
   code templates\story-en.html
   ```
   Add: `<p>Estimated reading: {{READING_TIME}}</p>`

2. **Edit Persian template:**
   ```powershell
   code templates\story-fa.html
   ```
   Add: `<p>زمان تقریبی مطالعه: {{READING_TIME}}</p>`

3. **Regenerate all stories:**
   ```powershell
   .\tools\generate-stories.ps1
   ```

4. **Done!** All 40 stories now show reading time.

---

## Quick Reference Commands

```powershell
# Generate all story pages
.\tools\generate-stories.ps1

# Generate main landing page  
.\tools\generate-index.ps1

# Do both at once
.\tools\generate-stories.ps1; .\tools\generate-index.ps1

# Preview changes locally
.\tools\generate-local-preview.ps1
```

---

## Benefits

✅ Change design for 40 stories in seconds  
✅ Add new stories quickly  
✅ Consistent structure automatically  
✅ Auto-generated navigation  
✅ Easy to reorder stories  
✅ One source of truth for content  
✅ Version control friendly  
✅ Scalable to 100+ stories  

---

## Need More Help?

See the full documentation:
- [TEMPLATE_SYSTEM.md](TEMPLATE_SYSTEM.md) - Complete system documentation
- [ADDING_STORIES.md](ADDING_STORIES.md) - Legacy manual method (deprecated)

---

**Remember:** With 40 stories, this system saves you from editing 80 HTML files every time you want to change something!
