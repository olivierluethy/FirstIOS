# FirstIOS

A first iOS/SwiftUI learning project: a Tinder-style swipeable card stack built
with SwiftUI. It contains two Xcode projects — `FirstIOS` (the card swiper) and
`PhotoSwiper` (a starter project).

## Features

- **Swipeable card stack** — a deck of cards you can dismiss with buttons:
  trash (discard), review, and like.
- **Monthly bars view** — a full-width bar visualization of the months of the
  year, highlighting the current month and day.
- Built entirely with SwiftUI views and state.

## Tech

- Swift + SwiftUI
- Xcode project (`FirstIOS.xcodeproj`)

## Run

1. Open `FirstIOS.xcodeproj` in Xcode (or `PhotoSwiper/PhotoSwiper.xcodeproj`).
2. Select an iOS Simulator (or a connected device).
3. Press **Run** (⌘R).

## Project structure

```
FirstIOS/
├── FirstIOS/              # main app: card swiper + monthly bars view
│   ├── FirstIOSApp.swift
│   ├── ContentView.swift
│   └── MonthlyBarsView.swift
└── PhotoSwiper/           # separate SwiftUI starter project
```
