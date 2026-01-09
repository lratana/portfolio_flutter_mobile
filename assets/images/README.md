# Portfolio Images Guide

## Image Structure

Your portfolio uses images from the `/public/images/` directory. Images in the `public` folder can be accessed directly via URLs like `/images/profile.png`.

## Required Images by Section

### 1. **Hero Section** (Profile & Background)

- **`/images/profile.png`** - Your profile photo (recommended: 400x400px, square)
- **`/images/hero-art.png`** - Background artwork (optional, recommended: 1920x1080px)
- **`/images/badges/degree.svg`** - Certification badge (optional, SVG format)

### 2. **Logo & Branding**

- **`/images/logo.svg`** - Your personal brand logo (SVG recommended for scalability)

### 3. **Works/Projects Gallery**

- **`/images/works/health-system.png`** - Health Information System project screenshot
- **`/images/works/enterprise.png`** - Enterprise Application screenshot
- **`/images/works/mobile.png`** - Mobile Application screenshot
- Add more project images as needed (recommended: 1200x800px or 16:9 ratio)

### 4. **Testimonials/Profile**

- **`/images/people/tech.png`** - Technical skills avatar (300x300px)
- **`/images/people/gov.png`** - Government projects avatar (300x300px)
- **`/images/people/learn.png`** - Learning/development avatar (300x300px)

### 5. **SEO/Social Sharing**

- **`/images/og-image.png`** - Open Graph image for social media sharing (1200x630px)

## How to Add Your Images

### Option 1: Using Your Own Photos

1. Prepare your images with the recommended dimensions
2. Save them to the appropriate folders:
   ```
   vue-project/public/images/
   ├── profile.png          (Your photo)
   ├── logo.svg             (Your logo)
   ├── hero-art.png         (Background)
   ├── og-image.png         (Social sharing)
   ├── works/
   │   ├── health-system.png
   │   ├── enterprise.png
   │   └── mobile.png
   ├── people/
   │   ├── tech.png
   │   ├── gov.png
   │   └── learn.png
   └── badges/
       └── degree.svg
   ```

### Option 2: Using Placeholder Images (for testing)

You can use placeholder services temporarily:

**Update MyData.json to use placeholders:**

```json
{
  "hero": {
    "avatar": "https://ui-avatars.com/api/?name=Long+Ratana&size=400&background=3b82f6&color=fff",
    "background": {
      "artwork": "https://placehold.co/1920x1080/1e40af/ffffff/png?text=Background"
    }
  },
  "works": {
    "items": [
      {
        "cover": "https://placehold.co/1200x800/3b82f6/ffffff/png?text=Health+System"
      }
    ]
  }
}
```

### Option 3: Creating Simple Placeholder Files

I can create simple SVG placeholders for you to replace later.

## Image Format Recommendations

| Type                | Format  | Size        | Notes                     |
| ------------------- | ------- | ----------- | ------------------------- |
| Profile Photo       | PNG/JPG | 400x400px   | Square, centered face     |
| Logo                | SVG     | Scalable    | Transparent background    |
| Project Screenshots | PNG/JPG | 1200x800px  | 16:9 or 3:2 ratio         |
| Avatars             | PNG/JPG | 300x300px   | Circular crop recommended |
| Background Art      | PNG/JPG | 1920x1080px | Subtle, not distracting   |
| OG Image            | PNG/JPG | 1200x630px  | For social media          |

## Quick Start: Create Placeholders

Run this PowerShell command in the terminal to create simple placeholder text files:

```powershell
"REPLACE_WITH_YOUR_PROFILE_PHOTO" | Out-File "public/images/profile.png.txt"
"REPLACE_WITH_PROJECT_SCREENSHOT" | Out-File "public/images/works/health-system.png.txt"
```

## Optimizing Images

Before adding images, optimize them:

- Use tools like TinyPNG, Squoosh, or ImageOptim
- Target file size: < 200KB for photos, < 100KB for screenshots
- Use WebP format for better compression (modern browsers)
- Consider lazy loading for gallery images

## Updating Image Paths

If you change folder structure, update `MyData.json`:

```json
{
  "hero": {
    "avatar": "/images/new-folder/profile.png"
  }
}
```

Paths starting with `/` reference from the `public` folder root.
