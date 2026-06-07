<div align="center">

# 🃏 CardGame
### War Card Game · iOS Assignment 1

<img src="https://img.shields.io/badge/Swift-5.9-F05138?style=for-the-badge&logo=swift&logoColor=white"/>
<img src="https://img.shields.io/badge/iOS-UIKit-147EFB?style=for-the-badge&logo=apple&logoColor=white"/>
<img src="https://img.shields.io/badge/Xcode-15-147EFB?style=for-the-badge&logo=xcode&logoColor=white"/>
<img src="https://img.shields.io/badge/Assignment-1-27AE60?style=for-the-badge"/>

<br/>

> Built with **UIKit** · **Landscape** · **CoreLocation** · **3 Screens**

</div>

---

## 🎬 Demo

<div align="center">

https://github.com/user-attachments/assets/d468fe3a-533c-419b-8633-4c934357bc83

</div>

---

## 📱 Screens

<div align="center">

| 🏠 Menu | 🎮 Game | 🏆 Summary |
|:-------:|:-------:|:----------:|
| Name input + location detection | 10 auto rounds with 5s timer | Winner & final score |
| East / West side assignment | Card flip animations | Back to menu |

</div>

---

## ⚙️ Features

<table>
<tr>
<td>

**🗺️ Location**
- Detects longitude on launch
- East `>` 34.8175 → East Side
- West `<` 34.8175 → West Side
- Stops updates after first fix

</td>
<td>

**🃏 Decks**
- East Side → red deck (♥ ♦)
- West Side → black deck (♠ ♣)
- Ace = 14 (strongest card)
- Decks shuffled on init

</td>
<td>

**🎮 Game**
- 10 rounds, no buttons
- 5s countdown per round
- Higher card wins points
- Tie → no points awarded

</td>
</tr>
<tr>
<td>

**💾 Persistence**
- Name saved via UserDefaults
- Restored on next launch
- English alphanumeric only

</td>
<td>

**🔁 Animations**
- UIView flip transition
- Card back → face reveal
- Spring score animation
- Fade-in on summary screen

</td>
<td>

**🏆 Result**
- Winner with final score
- Tie → PC (house) wins
- `"Winner: [name]"`
- `"score: [value]"`

</td>
</tr>
</table>

---

## 🏗️ Architecture

```
CardGame/
│
├── 📄 ViewController.swift       # Menu screen
├── 📄 GameController.swift       # Game screen — 10 rounds, timer, scoring
├── 📄 SummaryController.swift    # Summary screen — winner display
│
├── 📄 GameManager.swift          # Deck builder — red & black separate
├── 📄 LocationManager.swift      # CoreLocation wrapper + protocol
├── 📄 Extensions.swift           # Shared UI helpers (lecturer style)
└── 📄 card.swift                 # Card struct { value, imageName }
```

---

## 📐 CxR Pattern

> The lecturer's key principle — corner radius always set **proportionally** at layout time, never hardcoded.

```swift
// viewDidLayoutSubviews — never in viewDidLoad
btn.layer.cornerRadius   = btn.frame.height   * 0.35  // C × R (landscape)
card.layer.cornerRadius  = card.frame.width   * 0.07  // C × C (portrait)

// Card aspect ratio: height = width × 1.4  (R/C standard card ratio)
```

---

## 🚀 Run

```bash
git clone https://github.com/ofekfanian/CardGame.git
open CardGame.xcodeproj
```

Then press **⌘R** in Xcode.

> 📍 For location — **Simulator → Features → Location → Custom Location**
> Use longitude `> 34.8175` for East Side, `< 34.8175` for West Side.

---

<div align="center">

Made with ❤️ · Afeka College · iOS Development

</div>
