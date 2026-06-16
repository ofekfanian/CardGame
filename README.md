<div align="center">

# 🃏 CardGame

### *Flip your cards, beat your opponent, claim victory!*

> A location-based War card game for iOS featuring flip animations, GPS side assignment, and a 10-round countdown system.

<p>
  <img src="https://img.shields.io/badge/Platform-iOS-147EFB?style=flat&logo=apple&logoColor=white" alt="iOS" />
  <img src="https://img.shields.io/badge/Language-Swift-F05138?style=flat&logo=swift&logoColor=white" alt="Swift" />
  <img src="https://img.shields.io/badge/UI-UIKit-147EFB?style=flat" alt="UIKit" />
  <img src="https://img.shields.io/badge/IDE-Xcode-147EFB?style=flat&logo=xcode&logoColor=white" alt="Xcode" />
</p>

</div>

---

## 📌 About The Project

**CardGame** is a two-player War-style card game where your side of the board is determined by your real-world location. Players on the East side get red cards, West side gets black cards. Each round, two cards are revealed automatically — the stronger card wins points. After 10 rounds, the winner is displayed on the summary screen.

---

## 🎬 Demo

### ☀️ Light Mode

https://github.com/user-attachments/assets/0bb0fde7-8877-412b-a5d9-ee198d888b81

### 🌙 Dark Mode

https://github.com/user-attachments/assets/2dd74939-5ed5-4554-836d-054e3eaf733f

---

## ✨ Key Features

- **📍 Location-Based Sides** — Uses CoreLocation to detect your longitude. East of `34.817549168324334` → red deck (♥ ♦), West → black deck (♠ ♣)
- **🃏 Automatic Rounds** — No buttons on the game screen. Cards flip every 5 seconds automatically for 10 rounds
- **🏆 Scoring System** — Higher card wins the round and earns its value as points. Ace = 14 (strongest). Tie = no points
- **🔁 Flip Animations** — Smooth `UIView` transition animations on every card reveal and hide
- **💾 Persistent Name** — Player name saved via `UserDefaults` and restored on next launch
- **🎯 CxR Pattern** — All corner radii set proportionally in `viewDidLayoutSubviews` per lecturer spec

---

## 📱 Screens

| 🏠 Menu | 🎮 Game | 🏆 Summary |
|:-------:|:-------:|:----------:|
| Name input + location detection | 10 auto rounds · 5s timer per round | Winner with final score |

---

## 🏗️ Architecture

```
CardGame/
├── ViewController.swift       — Menu screen
├── GameController.swift       — Game screen (rounds, timer, scoring)
├── SummaryController.swift    — Summary screen (winner display)
├── GameManager.swift          — Deck builder, red & black decks
├── LocationManager.swift      — CoreLocation wrapper + delegate protocol
├── Extensions.swift           — Shared UI helpers
└── card.swift                 — Card struct { value, imageName }
```

---

## ⚙️ How to Run

1. Clone this repository
2. Open `CardGame.xcodeproj` in **Xcode**
3. Select a simulator or physical device
4. Hit **⌘R** to build and run


---

<div align="center">
  <b>Created by Ofek Fanian</b>
</div>
