# Simple Story Workflow - Just .txt Files!

## ✨ Super Simple: Add Stories with Just Text Files

You asked for the simplest possible workflow, and here it is! No JSON, no HTML - just plain text files.

---

## How It Works

### For Each Story, You Need:

1. **One English .txt file** (`story-en.txt`)
2. **One Persian .txt file** (`story-fa.txt`)
3. **(Optional) Images** in the same folder

That's it!

---

## Quick Start

### 1. Create Your Story Folder

```
stories-source/
  └── my-story-name/          ← Folder name becomes the URL
      ├── story-en.txt        ← English version
      ├── story-fa.txt        ← Persian version
      └── cover.jpg           ← (optional) Story image
```

### 2. Write Your Story in .txt Format

**File:** `stories-source/my-story-name/story-en.txt`

```
---
title: My Story Title
subtitle: A brief description of your story
genre: Fantasy
reading-time: 5 min
---

This is the first paragraph of your story.

This is the second paragraph. Use *asterisks* for italics.

Each paragraph is separated by a blank line.
```

**File:** `stories-source/my-story-name/story-fa.txt`

```
---
title: عنوان داستان من
subtitle: توضیح کوتاه داستان
genre: فانتزی
reading-time: ۵ دقیقه
---

این پاراگراف اول داستان شماست.

این پاراگراف دوم است. از *ستاره* برای ایتالیک استفاده کنید.

هر پاراگراف با یک خط خالی جدا می‌شود.
```

### 3. Build Everything

```powershell
.\tools\build-stories.ps1
```

**Done!** Your entire website is generated:
- All 40 story pages (EN + FA)
- Main index page
- Navigation links
- Everything!

---

## Managing 40 Stories

### Add a New Story

1. Create folder: `stories-source/story-41/`
2. Add `story-en.txt` and `story-fa.txt`
3. Run: `.\tools\build-stories.ps1`

### Edit a Story

1. Open the `.txt` file
2. Make changes
3. Run: `.\tools\build-stories.ps1`

### Change Design for All Stories

1. Edit: `templates/story-en.html`
2. Edit: `templates/story-fa.html`
3. Run: `.\tools\build-stories.ps1`

All 40 stories update with new design!

---

## Complete Workflow

### For 40 Stories:

```
stories-source/
  ├── 01-story-name/
  │   ├── story-en.txt
  │   └── story-fa.txt
  ├── 02-story-name/
  │   ├── story-en.txt
  │   └── story-fa.txt
  ...
  └── 40-story-name/
      ├── story-en.txt
      └── story-fa.txt
```

One command builds everything:
```powershell
.\tools\build-stories.ps1
```

---

## Benefits

✅ **Dead simple:** Just write in .txt files  
✅ **No HTML knowledge needed**  
✅ **No JSON editing**  
✅ **One command builds everything**  
✅ **Change design once, update all 40 stories**  
✅ **Auto-generated navigation**  

---

See [SIMPLE_WORKFLOW.md](SIMPLE_WORKFLOW.md) for complete documentation.
