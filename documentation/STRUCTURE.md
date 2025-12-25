# Project Structure

## Clean Organization

```
pages/
├── docs/                       ← WEBSITE OUTPUT (all files served to visitors)
│   ├── assets/                 ← CSS, images, fonts
│   ├── en/                     ← English story pages
│   ├── fa/                     ← Persian story pages
│   ├── index.html              ← Main landing page
│   └── local-preview.html      ← Preview file
│
├── stories-source/             ← YOUR SOURCE FILES (edit these)
│   ├── lady-prince/
│   │   ├── story-en.txt        ← Write your stories here
│   │   └── story-fa.txt
│   └── the-trial/
│       ├── story-en.txt
│       └── story-fa.txt
│
├── templates/                  ← DESIGN TEMPLATES
│   ├── story-en.html
│   ├── story-fa.html
│   └── index-template.html
│
└── tools/                      ← BUILD SCRIPTS
    ├── build-stories.ps1       ← Main build script
    ├── generate-stories.ps1
    ├── generate-index.ps1
    └── generate-local-preview.ps1
```

## What Goes Where

### ✏️ You Edit:
- `stories-source/` - Your .txt story files
- `templates/` - Design templates (optional)

### 🤖 Auto-Generated:
- `docs/` - Everything in here is built automatically

### 🌐 Website:
- `docs/` folder is served by GitHub Pages

## Workflow

1. Edit `.txt` files in `stories-source/`
2. Run: `.\tools\build-stories.ps1`
3. Output generated in `docs/`
4. Open: `docs\index.html` in browser
5. Commit and push everything

## GitHub Pages Setup

In your GitHub repository settings:
- Go to **Settings** → **Pages**
- Set source to: **Deploy from a branch**
- Select branch: **main**
- Select folder: **/docs**
- Save

Your site will be at: `https://pagesandscripts.github.io/`

## Benefits of This Structure

✅ Clean separation of source and output  
✅ All website files in one place (`docs/`)  
✅ Works perfectly with GitHub Pages  
✅ Easy to understand what's what  
✅ Can .gitignore docs/ if you build on server (advanced)  
