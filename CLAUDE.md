# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

This is an Xcode project. Open `Mapely.xcodeproj` in Xcode to build and run.

```bash
# Build from command line
xcodebuild build -project Mapely.xcodeproj -scheme Mapely -destination "platform=iOS Simulator,name=iPhone 16"

# Run tests
xcodebuild test -project Mapely.xcodeproj -scheme Mapely -destination "platform=iOS Simulator,name=iPhone 16"
```

The background removal feature requires a local Python Flask server running at `http://127.0.0.1:5000/remove-background`.

## Architecture

**MVVM with SwiftUI** and Firebase Auth.

**Entry point:** `ProjectApp.swift` → `RootView` (auth gate) → `MainView` (2-tab shell: Home + Closet)

**State:** `Model.swift` is a global `ObservableObject` injected as `@EnvironmentObject`. It holds:
- `allClothes: [ClothingItem]` — all clothing items (in-memory only, no persistence)
- `selectedClothes: [ClothingItem]` — currently selected outfit

**Auth:** `AuthentificationManager.shared` (singleton) wraps Firebase Auth. `RootView` switches between `AuthentificationView` and the main app based on auth state.

**Module layout:**
- `Authentification/` — sign-in, sign-up, password reset, settings, Firebase config (`GoogleService-Info.plist`)
- `Category/` — `Constants.swift` (all predefined options), `ClothingItem.swift` (data model), `CategoryView`
- `Closet/` — browse wardrobe (`ClosetView`), item detail (`ClothView`), add/edit (`UploadView`)
- `Home/Myself/` — manual outfit builder (`ClothingSelectorView`)
- `Others/` — shared model, `OptionView` (mood/occasion filter), `SubCategoryView`

**Data model (`ClothingItem`):** `id`, `imageData`, `category`, `subcategory`, `colorName`, `mood`, `season`, `occasion`, `brand`. All category/color/mood/season/occasion values are string constants defined in `Constants.swift`.

## Known Incomplete Areas

- `RecommendView.swift` — entirely commented out (automated outfit recommendation, WIP)
- `SubCategoryView.swift` — stub/empty implementation
- No data persistence — `allClothes` resets on every app launch
- Background removal hardcoded to `127.0.0.1:5000`

## Swift Files

### App Shell
- `ProjectApp.swift` — entry point; initializes Firebase, injects `Model` as environment object
- `MainView.swift` — root `TabView` with Home and Closet tabs
- `RootView.swift` — auth gate; shows `AuthentificationView` or `SettingView` based on login state

### Authentication (`Authentification/`)
- `AuthentificationManagert.swift` — `AuthentificationManager` singleton wrapping Firebase Auth; `AuthDataResultModel` struct
- `AuthentificationView.swift` — landing screen with navigation to email sign-in
- `SignInEmailView.swift` — sign-up / sign-in form; `SignInEmailViewModel` handles Firebase calls
- `UpdatePassView.swift` — password change form; `updatePassViewModel`
- `SettingView.swift` — settings menu (sign-out, email update, password update navigation); `SettingsViewModel`

### Data Layer
- `Others/Model.swift` — global `ObservableObject`; holds `allClothes` and `selectedClothes`
- `Category/ClothingItem.swift` — `ClothingItem` struct (Identifiable, Equatable); converts `imageData: Data` → `Image` on demand
- `Category/Constants.swift` — all predefined option arrays (`categoryData`, `colorOptions`, `moods`, `seasons`, `occasions`); `colorFromName()` utility

### Home / Outfit Builder
- `HomeView.swift` — "Today's Outfit" screen; buttons for "Style by Myself" and "Style for Me"
- `SelectedClothesView.swift` — bordered box wrapping `MannequinView`
- `MannequinView.swift` — layered `ZStack` rendering the selected outfit by category order
- `Home/Myself/ClothingSelectorView.swift` — carousel-style picker for one category; supports subcategory/color filters and a blacklist for rejected items
- `Others/OptionView.swift` — mood/occasion filter buttons *(actions not yet wired up)*
- `Others/SubCategoryView.swift` — empty stub
- `RecommendView.swift` — automated recommendation logic *(entirely commented out, WIP)*

### Closet
- `Closet/ClosetView.swift` — grid of all wardrobe items; navigates to `ClothView` or `UploadView`
- `Closet/ClothView.swift` — item detail view with delete and edit actions
- `Closet/UploadView.swift` — add/edit form; `PhotosPicker` for image selection; POSTs to local Flask server for background removal
