# Error Currency App

Error Currency is a gamified mobile application that allows users to complete interactive missions and earn virtual coins. The app integrates AI-powered image recognition for camera-based missions and provides a user-friendly dashboard to track rewards and progress.

---

## Features

- **Login System**: Simple login with fixed credentials for testing.
- **Dashboard**: Displays a greeting message, total wallet coins, and navigation buttons.
- **Wallet**: Shows total coins earned from missions.
- **Missions**:
  - Camera missions: Take photos of specific objects (e.g., laptop, earphones, door, Indian currency) and validate them using AI.
  - Quiz or other mission types can be added in separate containers.
- **Profile**: View completed missions and stats.
- **Coins History**: Track coins earned from completed missions.
- **Shop (Static)**: Displays dummy items that can be “purchased” using coins.
- **Bottom Navigation**: Quick access to Coins History, Missions, and Wallet.

> **Note:** Due to the use of the camera for missions, this project must be run on a **mobile device** or via **Android Studio with USB debugging enabled**.

---


## API Integration

This app uses the **[Imagga API](https://imagga.com/)** for image recognition in camera missions:

- **Purpose:** Automatically detects objects in photos and validates them against mission requirements.
- **Implementation:** When a user captures a photo, the app sends it to Imagga for tagging. The API returns a list of tags, which the app compares with the mission's required tags.
- **Setup:** Add your API credentials in `lib/features/missions/mission_camera_screen.dart`:

```dart
final String apiKey = 'YOUR_IMAGGA_API_KEY';
final String apiSecret = 'YOUR_IMAGGA_API_SECRET';

## Screenshots

*(Add screenshots of login, dashboard, missions, wallet, profile, and shop screens here)*

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code
- Mobile device or emulator for camera missions

### Installation

1. Clone the repository:

```bash
git clone <repository_url>
cd error_currency_app
flutter pub get // to get dart dependcy
flutter run