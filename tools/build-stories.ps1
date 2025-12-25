# Story Builder - Convert .txt files to website
# This script reads story .txt files and generates everything
# Usage: .\tools\build-stories.ps1

param(
    [string]$SourceDir = "stories-source",
    [switch]$Force
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir "..")
$sourcePath = Join-Path $repoRoot $SourceDir
$outputRoot = Join-Path $repoRoot "docs"

if (-not (Test-Path $sourcePath)) {
    Write-Error "Source directory not found: $sourcePath"
    exit 1
}

Write-Host "Building stories from $SourceDir..." -ForegroundColor Cyan

# Get all story folders
$storyFolders = Get-ChildItem -Path $sourcePath -Directory | Sort-Object Name

if ($storyFolders.Count -eq 0) {
    Write-Error "No story folders found in $sourcePath"
    exit 1
}

Write-Host "Found $($storyFolders.Count) story folders`n" -ForegroundColor Green

# Function to parse story text file
function Parse-StoryFile {
    param([string]$FilePath)
    
    if (-not (Test-Path $FilePath)) {
        return $null
    }
    
    $content = Get-Content $FilePath -Raw -Encoding UTF8
    
    # Extract frontmatter (metadata between ---)
    if ($content -match '(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n(.*)$') {
        $frontmatter = $matches[1]
        $body = $matches[2].Trim()
        
        # Parse metadata
        $metadata = @{}
        $frontmatter -split "`n" | ForEach-Object {
            if ($_ -match '^([^:]+):\s*(.+)$') {
                $key = $matches[1].Trim()
                $value = $matches[2].Trim()
                $metadata[$key] = $value
            }
        }
        
        # Convert body to HTML paragraphs
        $paragraphs = $body -split "\r?\n\r?\n" | Where-Object { $_.Trim() -ne "" }
        $htmlContent = ""
        
        foreach ($para in $paragraphs) {
            $para = $para.Trim()
            # Convert *text* to <em>text</em>
            $para = $para -replace '\*([^\*]+)\*', '<em>$1</em>'
            # Convert **text** to <strong>text</strong>
            $para = $para -replace '\*\*([^\*]+)\*\*', '<strong>$1</strong>'
            $htmlContent += "<p>$para</p>`n`n    "
        }
        
        return @{
            title = $metadata['title']
            subtitle = $metadata['subtitle']
            genre = $metadata['genre']
            readingTime = $metadata['reading-time']
            content = $htmlContent.TrimEnd()
        }
    }
    
    return $null
}

# Build story data JSON
$stories = @()

foreach ($folder in $storyFolders) {
    $slug = $folder.Name
    Write-Host "Processing: $slug" -ForegroundColor Yellow
    
    $enFile = Join-Path $folder.FullName "story-en.txt"
    $faFile = Join-Path $folder.FullName "story-fa.txt"
    
    $enData = Parse-StoryFile -FilePath $enFile
    $faData = Parse-StoryFile -FilePath $faFile
    
    if ($null -eq $enData -or $null -eq $faData) {
        Write-Warning "  Missing story files for $slug, skipping..."
        continue
    }
    
    $story = @{
        slug = $slug
        en = @{
            title = $enData.title
            subtitle = $enData.subtitle
            genre = $enData.genre
            readingTime = $enData.readingTime
            content = $enData.content
        }
        fa = @{
            title = $faData.title
            subtitle = $faData.subtitle
            genre = $faData.genre
            readingTime = $faData.readingTime
            content = $faData.content
        }
    }
    
    $stories += $story
    Write-Host "  Added: $($enData.title) / $($faData.title)" -ForegroundColor Green
}

# Save to stories-data.json
$dataOutput = @{
    stories = $stories
}

$jsonPath = Join-Path $repoRoot "stories-data.json"
$jsonContent = $dataOutput | ConvertTo-Json -Depth 10
Set-Content -Path $jsonPath -Value $jsonContent -Encoding UTF8

Write-Host "`nGenerated stories-data.json with $($stories.Count) stories" -ForegroundColor Green

# Now generate the HTML pages
Write-Host "`nGenerating HTML pages..." -ForegroundColor Cyan
& (Join-Path $scriptDir "generate-stories.ps1")

Write-Host "`nGenerating index page..." -ForegroundColor Cyan
& (Join-Path $scriptDir "generate-index.ps1")

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "BUILD COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Stories processed: $($stories.Count)" -ForegroundColor White
Write-Host "Next: Open index.html in your browser" -ForegroundColor White
