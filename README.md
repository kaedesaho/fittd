# Fittd

A personal wardrobe iOS app that helps you organize your clothes and build outfits visually.

## Features

- Upload clothing photos with automatic background removal
- Browse your wardrobe by category, color, mood, season, and occasion
- Build outfits by layering pieces onto a mannequin in real time
- Email/password authentication with JWT

## Tech Stack

| Layer | Technology |
|-------|-----------|
| iOS | SwiftUI, MVVM |
| Auth | JWT (custom backend) |
| Backend | Python, Flask |
| Image Processing | rembg, Pillow |

## Project Structure

```
Fittd/
├── ios/                  # SwiftUI iOS app
│   ├── Fittd/
│   │   ├── Authentification/   # Auth views & manager
│   │   ├── Closet/             # Wardrobe grid, item detail, upload
│   │   ├── Home/               # Outfit builder
│   │   ├── Category/           # Data model & constants
│   │   └── Others/             # Shared model, filters
│   └── Fittd.xcodeproj
└── backend/              # Flask API
    ├── app.py
    ├── config.py
    ├── db.py
    └── routes/
        ├── auth.py       # /register, /login, /update-password
        └── images.py     # /remove-background
```

## Getting Started

### Backend

```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
```

Server runs at `http://127.0.0.1:5000`.

### iOS

Open `ios/Fittd.xcodeproj` in Xcode and run on a simulator or device.

> The app expects the Flask server running locally for background removal and auth.

## API Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/register` | No | Create account |
| POST | `/login` | No | Sign in, returns JWT |
| POST | `/update-password` | JWT | Update password |
| POST | `/remove-background` | JWT | Remove image background |
