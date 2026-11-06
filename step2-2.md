# Step 2.2 – Flutter UI Plan

**Deadline:** 20 Nov 2026, 23:59 · **Design:** `CS310_Group41_Step2.1.pdf` (screen numbers refer to it)

## Who does what

| Package | Screens | Owner |
|---|---|---|
| Foundation + D | Theme, routes, shared widgets, mock data · 08–09 Add Experience, 13 Verification, 14 Admin, 15 Review | Ali |
| A | 03 Home, 07 Experience Detail, 10 Saved, 12 Profile | TBD |
| B | 01 Login, 02 Register, 04 Search, 04b Filters | Selin |
| C | 05 Organization List, 06 Organization Detail, 11 Following | TBD |

Foundation is pushed first; start your screens on top of it.

## Must-haves (course requirements)

- Working navigation between all screens (named routes)
- Placeholder data only; login/register are UI only
- Shared colors, text styles, spacing and reusable widgets; no overflow on small or large phones
- Local image (logo on 01), network image (organization logos), custom font (Inter)
- Cards with a working remove action → 10 Saved
- Form with ≥ 2 fields, inline validation and a confirmation dialog → 02 Register

## Project structure

```
lib/
  core/theme/    colors, text styles, spacing
  core/routes/   route names
  data/          models + mock_data.dart
  widgets/       shared widgets (ExperienceCard, chips, buttons, text field, badges)
  screens/       one folder per feature
```

## Screens in short

- **01 Login:** logo, email + password → 03; Sign up → 02
- **02 Register:** name, email, password, major, grad year; validation; dialog → 01
- **03 Home:** experience cards; Latest / Top rated / Verified chips → 07
- **04 Search:** search bar, Filters button, active filter chips, results → 07
- **04b Filters:** bottom sheet: type (multi-select), country/city, industry, tech, work type, rating, verified
- **05 Organizations:** type tabs, industry chips, A–Z list → 06
- **06 Organization Detail:** info, Follow, overview, department cards, experiences → 07
- **07 Experience Detail:** details, review, interview process, tech, similar; bookmark → 10
- **08–09 Add Experience:** 4-step form, validation, confirm dialog → 12
- **10 Saved:** saved cards, X removes
- **11 Following:** followed organizations, Unfollow
- **12 Profile:** info, links to 10/11/13/14, my experiences, log out → 01
- **13 Verification:** pick experience, upload document, my requests
- **14 Admin:** Pending / Approved / Rejected tabs → 15
- **15 Review:** document, reason, Approve / Reject with confirm

## Git

- Work on your own branch (e.g. `feature/b-auth-search`), merge into `main` with a PR
- `git pull origin main` before you start
- Commit small and often from your own account (graded)
