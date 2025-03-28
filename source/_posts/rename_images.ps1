$filePath = "blog-post1.md"
$content = Get-Content -Raw -Path $filePath

$imageIndex = 0

# Replace all instances of ![image.png](...)
$content = [regex]::Replace($content, "!\[image.png\]\([^)]*\)", {
    param($match)
    $replacement = "{% asset_image image_${script:imageIndex}.png %}"
    $script:imageIndex++
    return $replacement
})

# Save changes back to file
Set-Content -Path $filePath -Value $content
