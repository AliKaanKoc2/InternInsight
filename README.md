# InternInsight

InternInsight is a Flutter app where Sabancı University students share and explore internship experiences at companies, universities and research institutes.

**Course:** CS310 Mobile Application Development · **Group 41**

- **Step 1 coordinator:** Ali Kaan Koç
- **Step 2 coordinator:** Efe Osmanağaoğlu

## Current status: Step 2.2 (Flutter UI)

All 15 screens from our Step 2.1 wireframes are implemented with mock data. There is no backend yet: login, posting, following and verification work only inside the app session.

## Flutter version

- Flutter **3.47.9** (stable channel)
- Dart **3.13.7**

## How to run

1. Install Flutter 3.47.9 and start an Android emulator or iOS simulator.
2. In the project folder run:

```
   flutter pub get
   flutter run
```

3. Log in with any `@sabanciuniv.edu` email and any password.

The admin pages (14 and 15) are reached from **Profile → Admin verification**.

## Screens

| # | Screen | Reached from |
|---|--------|--------------|
| 01 | Login | App start |
| 02 | Register | Login → Sign up |
| 03 | Home Feed | Bottom bar |
| 04 / 04b | Search + Filters | Bottom bar |
| 05 | Organization List | Bottom bar |
| 06 | Organization Detail | Organization card, Experience Detail, Following |
| 07 | Experience Detail | Any experience card |
| 08–09 | Add Experience (2 steps) | Bottom bar → Add |
| 10 | Saved | Profile, bookmark on Experience Detail |
| 11 | Following | Profile |
| 12 | Profile | Bottom bar |
| 13 | Verification Upload | Profile |
| 14 | Admin Verification | Profile (admin) |
| 15 | Review Request | Admin Verification |

## Project structure

```
lib/
├── core/
│   ├── routes/      named routes (AppRoutes)
│   └── theme/       colors, spacing, text styles, app theme
├── data/
│   ├── models/      Experience, Organization, VerificationRequest
│   └── mock_*.dart  mock data and in-app state (saved, followed)
├── screens/         one folder per feature
├── widgets/         shared widgets (ExperienceCard, OrganizationCard)
└── main.dart
```

## Team and contributions

| Member | Work in Step 2.2 |
|--------|------------------|
| **Ali Kaan Koç** (33832) | Shared foundation (theme, routes, app shell, placeholders); Organization List (05), Organization Detail (06), Add Experience (08–09), Verification Upload (13), Admin Verification (14), Review Request (15); Organization and VerificationRequest models and mock data |
| **Efe Osmanağaoğlu** (33979) | Home Feed (03), Experience Detail (07), Saved (10), Following (11), Profile (12); Experience model, mock data, ExperienceCard, saved/followed state |
| **Selin İldeniz** (35847) | Login (01), Register (02), Search (04), Filters (04b) |

## Tech stack

- **Frontend:** Flutter & Dart
- **Backend (next steps):** Firebase / Python REST API
- **Database:** MySQL
