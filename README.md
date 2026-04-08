# AgarIO Menu - iOS App

Een volledige agar.io settings menu app voor iOS met subtabs voor elke categorie.

## Features

✨ **Volledige Menu Structuur**
- Gameplay instellingen
- Zoom controle (met rode indicator)
- Macro instellingen
- Mastersplit mode (met paarse indicator)
- Map instellingen (met groene indicator)

🎯 **Subtabs per Categorie**
- Elke menu item heeft meerdere subtabs
- Gameplay: Speed, Behavior, Visual
- Zoom: Level, Smooth, Auto
- Macro: Split, Feed, Eject
- Mastersplit: Mode, Speed, Advanced
- Map: Style, Size, Opacity

👤 **Gebruiker: @dtje029**

## Vereisten

- macOS met Xcode 15.0+
- iOS 14.0+ deployment target
- Swift 5.0+

## Build Instructies

### 1. Project openen in Xcode
```bash
open AgarIOMenu.xcodeproj
```

### 2. IPA bestand genereren
```bash
chmod +x build_ipa.sh
./build_ipa.sh
```

De .ipa file wordt gegenereerd in: `build/ipa/AgarIOMenu.ipa`

### 3. Handmatig bouwen in Xcode
1. Select "AgarIOMenu" scheme
2. Select "Any iOS Device (arm64)"
3. Product → Archive
4. Organizer → Distribute App → Ad Hoc
5. Selecteer signing options
6. Export IPA

## Installatie op iOS Device

### Via Xcode
1. Connect iOS device
2. Select device in Xcode
3. Product → Run

### Via IPA bestand
1. Gebruik Transporter app (Mac App Store)
2. Sleep de .ipa file naar Transporter
3. Of gebruik: `ios-app-installer` tool

## Project Structuur

```
AgarIOMenu/
├── AgarIOMenuApp.swift      # App entry point
├── ContentView.swift         # Main UI & navigation
├── Info.plist               # App configuration
└── Assets.xcassets          # App icons & assets

AgarIOMenu.xcodeproj/        # Xcode project
ExportOptions.plist          # IPA export settings
build_ipa.sh                 # Build script
```

## Compatibiliteit

✅ iOS 14.0+
✅ iPhone & iPad
✅ Landscape & Portrait
✅ Laatste agar.io updates

## Aanpassingen

### Gebruikersnaam wijzigen
Edit `ContentView.swift` regel met `@dtje029`:
```swift
Text("@dtje029")
```

### Menu items toevoegen
Voeg toe in `MainMenuView`:
```swift
MenuRow(
    title: "Nieuw Item",
    icon: Circle().fill(Color.blue),
    action: { /* action */ }
)
```

### Subtabs aanpassen
Edit de `tabs` array in `DetailView`:
```swift
case "Gameplay":
    return ["Speed", "Behavior", "Visual", "Nieuw Tab"]
```

## Licentie

Privé project voor agar.io menu management.
