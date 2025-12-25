# Story Pages Generator
# This script generates all story HTML pages from templates and data
# Usage: .\tools\generate-stories.ps1

param(
    [string]$DataFile = "stories-data.json",
    [string]$TemplateDir = "templates",
    [switch]$Force
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir "..")
$outputRoot = Join-Path $repoRoot "docs"

$dataPath = Join-Path $repoRoot $DataFile
$templateDirPath = Join-Path $repoRoot $TemplateDir

# Load story data
if (-not (Test-Path $dataPath)) {
    Write-Error "Story data file not found: $dataPath"
    exit 1
}

Write-Host "Loading story data from $DataFile..." -ForegroundColor Cyan
$storyData = Get-Content $dataPath -Raw | ConvertFrom-Json

# Load templates
$enTemplatePath = Join-Path $templateDirPath "story-en.html"
$faTemplatePath = Join-Path $templateDirPath "story-fa.html"

if (-not (Test-Path $enTemplatePath)) {
    Write-Error "English template not found: $enTemplatePath"
    exit 1
}

if (-not (Test-Path $faTemplatePath)) {
    Write-Error "Persian template not found: $faTemplatePath"
    exit 1
}

$enTemplate = Get-Content $enTemplatePath -Raw
$faTemplate = Get-Content $faTemplatePath -Raw

Write-Host "Templates loaded successfully." -ForegroundColor Green

# Generate stories
$stories = $storyData.stories
$storyCount = $stories.Count

Write-Host "`nGenerating $storyCount stories..." -ForegroundColor Cyan

for ($i = 0; $i -lt $storyCount; $i++) {
    $story = $stories[$i]
    $slug = $story.slug
    
    Write-Host "`n[$($i+1)/$storyCount] Processing: $slug" -ForegroundColor Yellow
    
    # Determine previous and next stories
    $prevStory = if ($i -gt 0) { $stories[$i-1] } else { $null }
    $nextStory = if ($i -lt ($storyCount - 1)) { $stories[$i+1] } else { $null }
    
    # Generate English version
    $enDir = Join-Path $outputRoot "en\stories\$slug"
    $enPath = Join-Path $enDir "index.html"
    
    if (-not (Test-Path $enDir)) {
        New-Item -ItemType Directory -Path $enDir -Force | Out-Null
    }
    
    # Replace placeholders for English
    $enContent = $enTemplate
    $enContent = $enContent -replace '{{TITLE}}', $story.en.title
    $enContent = $enContent -replace '{{SUBTITLE}}', $story.en.subtitle
    $enContent = $enContent -replace '{{GENRE}}', $story.en.genre
    $enContent = $enContent -replace '{{READING_TIME}}', $story.en.readingTime
    $enContent = $enContent -replace '{{SLUG}}', $slug
    $enContent = $enContent -replace '{{FA_TITLE}}', $story.fa.title
    $enContent = $enContent -replace '{{CONTENT}}', $story.en.content
    
    # Generate navigation links
    if ($prevStory) {
        $prevSlug = $prevStory.slug
        $prevTitle = $prevStory.en.title
        $prevLink = "<a class=""story-nav-link"" href=""../$prevSlug/index.html"">Previous story: $prevTitle</a>"
    } else {
        $prevLink = "<span class=""story-nav-link story-nav-disabled"">Previous story</span>"
    }
    
    if ($nextStory) {
        $nextSlug = $nextStory.slug
        $nextTitle = $nextStory.en.title
        $nextLink = "<a class=""story-nav-link"" href=""../$nextSlug/index.html"">Next story: $nextTitle</a>"
    } else {
        $nextLink = "<span class=""story-nav-link story-nav-disabled"">Next story</span>"
    }
    
    $enContent = $enContent -replace '{{PREV_LINK}}', $prevLink
    $enContent = $enContent -replace '{{NEXT_LINK}}', $nextLink
    
    # Write English file
    Set-Content -Path $enPath -Value $enContent -Encoding UTF8
    Write-Host "  Created: en/stories/$slug/index.html" -ForegroundColor Green
    
    # Generate Persian version
    $faDir = Join-Path $outputRoot "fa\stories\$slug"
    $faPath = Join-Path $faDir "index.html"
    
    if (-not (Test-Path $faDir)) {
        New-Item -ItemType Directory -Path $faDir -Force | Out-Null
    }
    
    # Replace placeholders for Persian
    $faContent = $faTemplate
    $faContent = $faContent -replace '{{TITLE}}', $story.fa.title
    $faContent = $faContent -replace '{{SUBTITLE}}', $story.fa.subtitle
    $faContent = $faContent -replace '{{GENRE}}', $story.fa.genre
    $faContent = $faContent -replace '{{READING_TIME}}', $story.fa.readingTime
    $faContent = $faContent -replace '{{SLUG}}', $slug
    $faContent = $faContent -replace '{{EN_TITLE}}', $story.en.title
    $faContent = $faContent -replace '{{CONTENT}}', $story.fa.content
    
    # Generate navigation links for Persian
    if ($prevStory) {
        $prevSlug = $prevStory.slug
        $prevTitle = $prevStory.fa.title
        $prevLinkFa = @"
<a class="story-nav-link" href="../$prevSlug/index.html">داستان قبلی: $prevTitle</a>
"@
    } else {
        $prevLinkFa = @"
<span class="story-nav-link story-nav-disabled">داستان قبلی</span>
"@
    }
    
    if ($nextStory) {
        $nextSlug = $nextStory.slug
        $nextTitle = $nextStory.fa.title
        $nextLinkFa = @"
<a class="story-nav-link" href="../$nextSlug/index.html">داستان بعدی: $nextTitle</a>
"@
    } else {
        $nextLinkFa = @"
<span class="story-nav-link story-nav-disabled">داستان بعدی</span>
"@
    }
    
    $faContent = $faContent -replace '{{PREV_LINK}}', $prevLinkFa
    $faContent = $faContent -replace '{{NEXT_LINK}}', $nextLinkFa
    
    # Write Persian file
    Set-Content -Path $faPath -Value $faContent -Encoding UTF8
    Write-Host "  Created: fa/stories/$slug/index.html" -ForegroundColor Green
    
    # Create custom.css files if they don't exist
    $enCss = Join-Path $enDir "custom.css"
    if (-not (Test-Path $enCss)) {
        $enCssContent = "/* Custom styles for story */`n/* Add any story-specific CSS here */`n"
        Set-Content -Path $enCss -Value $enCssContent -Encoding UTF8
        Write-Host "  Created: en/stories/$slug/custom.css" -ForegroundColor Green
    }
    
    $faCss = Join-Path $faDir "custom.css"
    if (-not (Test-Path $faCss)) {
        $faCssContent = "/* Custom styles for story */`n/* Add any story-specific CSS here */`n"
        Set-Content -Path $faCss -Value $faCssContent -Encoding UTF8
        Write-Host "  Created: fa/stories/$slug/custom.css" -ForegroundColor Green
    }
    
    # Create images directories if they don't exist
    $enImgDir = Join-Path $enDir "images"
    $faImgDir = Join-Path $faDir "images"
    
    if (-not (Test-Path $enImgDir)) {
        New-Item -ItemType Directory -Path $enImgDir -Force | Out-Null
    }
    if (-not (Test-Path $faImgDir)) {
        New-Item -ItemType Directory -Path $faImgDir -Force | Out-Null
    }
}

Write-Host "`nSuccessfully generated all story pages!" -ForegroundColor Green
Write-Host "`nTo update the main landing page index, run: .\tools\generate-index.ps1" -ForegroundColor Cyan
