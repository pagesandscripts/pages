# Stories Source Folder

This folder contains your story source files in simple `.txt` format.

## Structure

Each story gets its own folder:

```
stories-source/
  ├── story-name-1/
  │   ├── story-en.txt      ← English version
  │   ├── story-fa.txt      ← Persian version
  │   └── images/ (optional)
  ├── story-name-2/
  │   ├── story-en.txt
  │   └── story-fa.txt
  └── ...
```

## File Format

Each `.txt` file has metadata at the top, then your story:

```
---
title: Story Title
subtitle: Brief description
genre: Genre name
reading-time: X min
---

Your story content starts here.

Each paragraph is separated by a blank line.

Use *asterisks* for italics.
```

## To Add a Story

1. Create a new folder (e.g., `my-new-story/`)
2. Add `story-en.txt` and `story-fa.txt`
3. Run: `.\tools\build-stories.ps1` from the root folder

## Examples

See `lady-prince/` and `the-trial/` for examples.

## Folder Naming

- Use lowercase
- Use hyphens for spaces (e.g., `the-black-cat`)
- Keep it short and URL-friendly
- To control order, use numbers: `01-first`, `02-second`, etc.
