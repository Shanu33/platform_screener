# 📱 platform_screener


[![pub package](https://img.shields.io/pub/v/platform_screener.svg?logo=dart)](https://pub.dev/packages/platform_screener)
[![Likes](https://img.shields.io/pub/likes/platform_screener?logo=dart)](https://pub.dev/packages/platform_screener)
[![Pub Points](https://img.shields.io/pub/points/platform_screener?logo=dart)](https://pub.dev/packages/platform_screener)


**`platform_screener` is the ultimate cross-platform + orientation detector for Flutter.**

A fast, reliable way to detect whether your app is running on Android, iOS, Windows, Linux, macOS, Web (desktop or mobile), PWA, or even "Desktop Site Requested" on mobile — along with orientation detection (portrait or landscape).

---

## 🚀 Why Choose platform_screener?

✔️ Detects **every runtime condition** relevant to responsive design.

✔️ Clean API – use anywhere in widgets or logic.

✔️ Provides **3 ready-to-use Widgets** to render UI by platform/orientation.

✔️ Handles **edge cases** other libraries ignore (PWA, browser type, user-agent overrides).


---

## 🔧 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  platform_screener: ^0.0.3
```

Run:

```bash
flutter pub get
```

---

## 📦 API Quick Start

### ➤ Import It

```dart
import 'package:platform_screener/platform_screener.dart';
```

### ➤ Detect Orientation

```dart
final mode = getScreenMode(context);
if (mode == ScreenMode.landscape) {
  // show landscape layout
}
```

### ➤ Detect Platform

```dart
if (deviceDetector.isAndroidNative) { ... }
if (deviceDetector.isPWA_Mobile) { ... }
if (deviceDetector.isRequestedDeskOnMob) { ... }
```

---

## 🧩 Built-in Widgets

### 🔹 `platform_screenerByPlatform`

Render different widgets per platform (or fallback automatically):

```dart
platform_screenerByPlatform(
  android: AndroidWidget(),
  ios: IOSWidget(),
  mobile: MobileFallback(),
  desktop: DesktopFallback(),
  fallback: DefaultWidget(),
)
```

---

### 🔹 `platform_screenerByOrientation`

```dart
platform_screenerByOrientation(
  portrait: PortraitView(),
  landscape: LandscapeView(),
)
```

---

### 🔹 `platform_screenerByPlatformAndOrientation`

Render platform + orientation-specific widgets in one go:

```dart
platform_screenerByPlatformAndOrientation(
  android: (context, mode) => mode == ScreenMode.portrait
      ? AndroidPortrait()
      : AndroidLandscape(),
  windows: (context, mode) => WindowsView(mode: mode),
  fallback: (context, mode) => DefaultLayout(),
)
```

---

## 🔍 Platform Detection Matrix

| Platform                 | Property               |
| ------------------------ | ---------------------- |
| Android Native           | `isAndroidNative`      |
| iOS Native               | `isIosNative`          |
| Windows                  | `isWindowsNative`      |
| macOS                    | `isMacOSNative`        |
| Linux                    | `isLinuxNative`        |
| Web: Mobile Browser      | `isMobileBrowser`      |
| Web: Desktop Browser     | `isDesktopBrowser`     |
| PWA on Mobile            | `isPWA_Mobile`         |
| PWA on Desktop           | `isPWA_Desktop`        |
| Desktop Site on Mobile   | `isRequestedDeskOnMob` |
| Any Mobile (native/web)  | `isMobile`             |
| Any Desktop (native/web) | `isDesktop`            |

---

## 🔄 Real-world Use Cases

* Show different layouts for mobile vs desktop
* Support PWA-specific logic
* Disable drag & drop on mobile browsers
* Tune spacing, padding, or font sizes by device
* Detect "Desktop Site" requested from mobile browser

---

## 📁 Directory Structure

```
lib/
├── platform_screener.dart                   # Public API
└── src/
    ├── platform_utils.dart         # Platform logic
    ├── platform_utils_io.dart      # IO detection
    ├── platform_utils_web.dart     # Web detection
    ├── pwa_utils.dart              # PWA helpers
    └── pwa_utils_stub.dart         # Stub fallback
```

---

## 👨‍💻 Maintainer

Built by [Shahnawaz Khan (Shanu)](https://github.com/Shanu33) with ❤️

---

## 📮 Issues & Contributions

📌 [Open issues](https://github.com/Shanu33/platform_screener/issues) or send [pull requests](https://github.com/Shanu33/platform_screener/pulls)

---

## ⚖️ License

[MIT](https://opensource.org/licenses/MIT)

> "Design once, adapt anywhere — with `platform_screener`."
