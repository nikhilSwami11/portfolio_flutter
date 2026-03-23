<div align="center">

# 📱 Flutter Portfolio — Phone Emulator Edition

### A stunning, interactive developer portfolio built with Flutter for Web — disguised as a phone.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/BLoC-State_Management-blueviolet?style=for-the-badge)](https://bloclibrary.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<br/>

> **Not just a portfolio. It's an experience.** ✨
>
> Your resume lives inside a virtual phone — with apps, games, settings, and smooth animations.

</div>

---

## 🎯 What Makes This Different?

Most developer portfolios are static pages. This one is a **fully interactive phone emulator** embedded in a sleek, dark-themed landing page — visitors explore your portfolio the same way they'd use a phone.

### ✨ Highlights

| Feature | Description |
|---|---|
| 📱 **Phone Emulator** | A virtual phone with app icons, navigation, and multiple screens |
| 🐱 **Animated Onboarding** | A playful cat-meets-black-hole entrance animation |
| 🎮 **Built-in Mini Games** | Snake, Tic-Tac-Toe, and a Calculator — right inside the phone |
| 🌙 **Dark Mode & Themes** | iOS-style settings with dark mode toggle and accent color picker |
| 🎬 **Staggered Animations** | Apple-inspired fade-up text cascade on the hero section |
| 📄 **JSON-Driven Content** | All portfolio data lives in a single JSON file — zero code changes needed |
| 🏗️ **Clean Architecture** | BLoC pattern + feature-based folder structure |

---

## 🖼️ Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── constants/                     # Assets, strings, paddings, globals
│   ├── cubit/                         # Portfolio state management
│   ├── models/                        # JSON-serializable data models
│   ├── navigation/                    # Route generator & helpers
│   ├── repository/                    # Data repository layer
│   ├── theme/                         # Colors & text styles
│   └── widgets/                       # Shared widgets (glassmorphism, etc.)
└── feature/
    ├── home/
    │   └── presentation/
    │       ├── screens/main_page.dart # Hero section + emulator + footer
    │       └── widgets/               # Experience timeline, skills grid, socials
    └── emulator/
        ├── data/                      # Banner models
        ├── domain/                    # Repositories
        └── presentation/
            ├── cubit/                 # Settings, navigation, light cubits
            ├── screen/                # All phone screens ↓
            │   ├── onboarding_screen  # Cat animation entry
            │   ├── app_home_screen    # App grid (phone home)
            │   ├── nikhil_home_screen # Portfolio hub inside phone
            │   ├── about_screen       # Bio + skills
            │   ├── experience_screen  # Work history
            │   ├── education_screen   # Academic background
            │   ├── snake_game_screen  # 🐍 Snake game
            │   ├── tic_tac_toe_screen # ❌⭕ Tic-Tac-Toe
            │   ├── calculator_screen  # 🔢 Calculator
            │   └── settings_screen    # ⚙️ Theme & color settings
            └── widget/                # Emulator shell, nav bar, cards, etc.
```

---

## 🚀 Quick Start

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (≥ 2.19.1)
- A modern browser (Chrome recommended)

### Run Locally

```bash
# Clone the repository
git clone https://github.com/nikhilSwami11/portfolio_flutter.git
cd portfolio_flutter

# Install dependencies
flutter pub get

# Launch in Chrome
flutter run -d chrome
```

### Build for Production

```bash
flutter build web
```

The output will be in `build/web/` — deploy it to GitHub Pages, Vercel, Netlify, or any static host.

---

## 🎨 Make It Yours — Customization Guide

### 1️⃣ Update Your Content

All portfolio data lives in **one file**: [`assets/data/portfolio.json`](assets/data/portfolio.json)

```jsonc
{
  "landing": {
    "title": "Your Name",
    "projectTitle": "Your Title  •  Your Role",
    "projectDescription": "A catchy one-liner about you.",
    ...
  },
  "about": {
    "description": "Tell your story here...",
    "skillGroups": [ ... ],
    ...
  },
  "experiences": [ ... ],
  "education": [ ... ],
  "socialLinks": [ ... ]
}
```

> **That's it. No Dart code changes needed for basic personalization.**

### 2️⃣ Update Assets

| What | Where |
|---|---|
| Profile photo | `assets/images/` |
| Company logos | `assets/icons/` |
| App icon | `assets/icon/icon.png` |
| Social icons | `assets/icons/` |

### 3️⃣ Update Hero Text & Strings

Edit [`lib/core/constants/string_constants.dart`](lib/core/constants/string_constants.dart) for the landing page hero lines.

### 4️⃣ Customize Theme

| File | What it controls |
|---|---|
| `lib/core/theme/colors.dart` | App color palette |
| `lib/core/theme/text_styles.dart` | Typography system |
| `pubspec.yaml` | Custom fonts (CourierPrime, Inter) |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Web) |
| **Language** | Dart |
| **State Management** | flutter_bloc / Cubit |
| **Data** | JSON + json_serializable |
| **UI Components** | NeoPop, Glassmorphism, Custom Animations |
| **Navigation** | Custom route generator with animation support |
| **Fonts** | Courier Prime, Inter |

---

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management via Cubits |
| `neopop` | NeoPop-style button components |
| `url_launcher` | Opening external links & email |
| `json_annotation` / `json_serializable` | Type-safe JSON parsing |
| `math_expressions` | Calculator expression evaluation |
| `equatable` | Value equality for state classes |
| `intl` | Date & number formatting |

---

## 🌐 Deployment

### GitHub Pages (recommended)

1. Build the web app:
   ```bash
   flutter build web --base-href "/portfolio_flutter/"
   ```
2. Push the `build/web/` contents to a `gh-pages` branch, or use a GitHub Action.

### Vercel / Netlify

Just point the build command to `flutter build web` and the output directory to `build/web`.

---

## 🤝 Contributing

Contributions are welcome! If you'd like to improve this template:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

<div align="center">

**⭐ If you found this useful, give it a star! ⭐**

Built with 💙 and Flutter

</div>
