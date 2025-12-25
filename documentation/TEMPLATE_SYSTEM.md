# Template-Based Story Management System

## Overview

This system allows you to manage all your stories from a single data file and templates. When you want to change the design, you only need to edit the template files and regenerate all pages.

## File Structure

```
pages/
├── stories-data.json          # All story content and metadata
├── templates/
│   ├── story-en.html         # English story page template
│   ├── story-fa.html         # Persian story page template
│   └── index-template.html   # Main landing page template
├── tools/
│   ├── generate-stories.ps1  # Generates all story pages
│   └── generate-index.ps1    # Generates main index.html
├── en/stories/...            # Generated English stories
├── fa/stories/...            # Generated Persian stories
└── index.html                # Generated main page
```

## Quick Start

### 1. Add a New Story

Edit `stories-data.json` and add your story:

```json
{
  "slug": "your-story-slug",
  "en": {
    "title": "Your Story Title",
    "subtitle": "Story description",
    "genre": "Genre",
    "readingTime": "5 min",
    "content": "<p>Your story content...</p>"
  },
  "fa": {
    "title": "عنوان فارسی",
    "subtitle": "توضیحات",
    "genre": "ژانر",
    "readingTime": "۵ دقیقه",
    "content": "<p>محتوای داستان...</p>"
  }
}
```

### 2. Generate All Pages

Run the generator script:

```powershell
.\tools\generate-stories.ps1
```

This will:
- Generate all story pages (both English and Persian)
- Create navigation links automatically
- Create folder structure if needed
- Preserve custom.css files

### 3. Update Main Index

Generate the landing page:

```powershell
.\tools\generate-index.ps1
```

### 4. Run Both at Once

```powershell
.\tools\generate-stories.ps1; .\tools\generate-index.ps1
```

## Change Design for All Stories

**This is the key benefit!** To change the design across all 40 stories:

1. Edit the template files in `templates/`:
   - `story-en.html` - English story page layout
   - `story-fa.html` - Persian story page layout
   - `index-template.html` - Main page layout

2. Regenerate all pages:
   ```powershell
   .\tools\generate-stories.ps1
   ```

3. That's it! All 40 stories now have the new design.

## Template Variables

### Story Templates (story-en.html, story-fa.html)

- `{{TITLE}}` - Story title
- `{{SUBTITLE}}` - Story subtitle
- `{{GENRE}}` - Story genre
- `{{READING_TIME}}` - Reading time
- `{{SLUG}}` - Story URL slug
- `{{FA_TITLE}}` / `{{EN_TITLE}}` - Title in other language
- `{{CONTENT}}` - Story HTML content
- `{{PREV_LINK}}` - Previous story link (auto-generated)
- `{{NEXT_LINK}}` - Next story link (auto-generated)

### Index Template (index-template.html)

- `{{EN_STORY_LIST}}` - Auto-generated English story list
- `{{FA_STORY_LIST}}` - Auto-generated Persian story list

## Story Content Format

Story content in `stories-data.json` should be HTML:

```json
"content": "<p>Paragraph one.</p>\n\n<p>Paragraph two with <em>emphasis</em>.</p>"
```

**Tips:**
- Use `\n` for newlines in JSON
- Use `<em>` for italics, `<strong>` for bold
- Escape quotes with `\"`
- Use proper HTML entities for special characters

## Custom Styling

Each story can have custom CSS:
- `en/stories/[slug]/custom.css`
- `fa/stories/[slug]/custom.css`

These files are NOT overwritten by the generator, so story-specific styles are preserved.

## Story Order

Stories appear in the order they're listed in `stories-data.json`. To reorder:
1. Rearrange the array in `stories-data.json`
2. Run `.\tools\generate-stories.ps1`
3. Run `.\tools\generate-index.ps1`

Navigation links will automatically update.

## Workflow Example

**Scenario:** You have 40 stories and want to add a "Share" button to all of them.

**Old way:** Edit 80 HTML files (40 EN + 40 FA) manually 😱

**New way:**
1. Edit `templates/story-en.html` - add share button to footer
2. Edit `templates/story-fa.html` - add share button to footer
3. Run: `.\tools\generate-stories.ps1`
4. Done! All 40 stories updated in seconds ✨

## Best Practices

1. **Always edit `stories-data.json` for content changes**
   - Don't manually edit generated HTML files
   - They'll be overwritten on next generation

2. **Keep templates generic**
   - Story-specific styling goes in `custom.css`
   - Templates should work for any story

3. **Version control**
   - Commit templates and data files
   - Generated files can be regenerated anytime

4. **Testing changes**
   - Test template changes on one story first
   - Then regenerate all when satisfied

## Migration from Manual Pages

To convert your existing manual pages to this system:

1. Copy content from each story's `index.html` into `stories-data.json`
2. Extract the story text from between `<main>` tags
3. Keep custom.css files as-is (they're preserved)
4. Run the generator to verify everything works
5. Once verified, the old manual HTML files can be replaced

## Troubleshooting

**Problem:** Script can't find files
- **Solution:** Run scripts from the repository root or check file paths

**Problem:** Stories are out of order
- **Solution:** Reorder the array in `stories-data.json`

**Problem:** Custom CSS disappeared
- **Solution:** The generator preserves existing custom.css files. Check if the file exists.

**Problem:** Special characters look wrong
- **Solution:** Ensure JSON file is saved as UTF-8 encoding

## Advanced Usage

### Generate specific stories only

Modify `generate-stories.ps1` to add a `-StorySlug` parameter for selective generation.

### Different templates per genre

Create genre-specific templates and add logic to select template based on story data.

### Automated workflow

Set up a Git hook to regenerate pages on commit:
```powershell
# .git/hooks/pre-commit
.\tools\generate-stories.ps1
.\tools\generate-index.ps1
git add en/ fa/ index.html
```

## Benefits Summary

✅ Change design once, update all 40 stories  
✅ Add new stories in seconds  
✅ Consistent structure across all pages  
✅ No manual HTML editing  
✅ Automatic navigation links  
✅ Easy to reorder stories  
✅ Version control friendly  
✅ Scalable to 100+ stories  

---

**Need help?** Check the example stories in `stories-data.json` or review the template files.
