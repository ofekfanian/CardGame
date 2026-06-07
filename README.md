# CardGame — War Card Game

![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square&logo=swift)
![Platform](https://img.shields.io/badge/Platform-iOS-blue?style=flat-square&logo=apple)
![Assignment](https://img.shields.io/badge/Assignment-1-green?style=flat-square)

iOS card game built with UIKit. Landscape layout, 3 screens.

---

## Demo

https://github.com/user-attachments/assets/d468fe3a-533c-419b-8633-4c934357bc83

---

## How It Works

- On launch the app detects your location — East of longitude `34.817549168324334` plays with red cards, West plays with black cards
- The game runs 10 automatic rounds with a 5 second timer each round
- Higher card wins the round · Ace = 14 · Tie = no points
- After 10 rounds the summary screen shows the winner

---

## Screens

| Menu | Game | Summary |
|------|------|---------|
| Name input + location detection | 10 rounds with 5s timer | Winner & final score |

---

## Architecture

```
ViewController.swift       — Menu
GameController.swift       — Game
SummaryController.swift    — Summary
GameManager.swift          — Deck logic
LocationManager.swift      — CoreLocation
Extensions.swift           — Shared helpers
card.swift                 — Card struct
```
