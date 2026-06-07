# 🃏 CardGame — War Card Game

> iOS card game assignment built with UIKit · Landscape · 3 screens

![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square&logo=swift)
![Platform](https://img.shields.io/badge/Platform-iOS-blue?style=flat-square&logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-15-147EFB?style=flat-square&logo=xcode)
![Assignment](https://img.shields.io/badge/Assignment-1-green?style=flat-square)

---

## 🎬 Demo

https://github.com/user-attachments/assets/d468fe3a-533c-419b-8633-4c934357bc83

---

## 📱 Screens

| Menu | Game | Summary |
|------|------|---------|
| Name input + location detection | 10 auto rounds with 5s timer | Winner & final score |

---

## ⚙️ Features

- 📍 **Location-based sides** — East of longitude `34.817549168324334` → East Side (red deck), West → black deck
- 🃏 **Separate decks** — red suits (hearts & diamonds) vs black suits (spades & clubs)
- ⏱️ **Auto timer** — 5 seconds per round, no buttons needed
- 🏆 **Scoring** — highest card wins the round · Ace = 14 (strongest)
- 💾 **Persistent name** — saved via UserDefaults across sessions
- 🔁 **Flip animation** — UIView transition on every card reveal

---

## 🏗️ Architecture

```
CardGame/
├── ViewController.swift       # Menu screen
├── GameController.swift       # Game screen
├── SummaryController.swift    # Summary screen
├── GameManager.swift          # Deck logic
├── LocationManager.swift      # CoreLocation wrapper
├── Extensions.swift           # Shared helpers
└── card.swift                 # Card struct
```

---

## 📐 CxR Pattern

Corner radius is always set **proportionally** in `viewDidLayoutSubviews`:

```swift
btn.layer.cornerRadius = btn.frame.height * 0.35   // C × R
imgCard.layer.cornerRadius = imgCard.frame.width * 0.07
```

---

## 🚀 Run

1. Clone the repo
2. Open `CardGame.xcodeproj`
3. Select a simulator or device
4. **⌘R**

> For location testing — use **Xcode Simulator → Features → Location**
