import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'src/platform_utils.dart';
import 'src/pwa_utils.dart';

var _size;

/// Defines screen orientation modes.
enum ScreenMode { portrait, landscape }

/// Detects the current screen orientation (portrait or landscape).
ScreenMode getScreenMode(BuildContext context) {
  final size = _size = MediaQuery.of(context).size;
  return size.width >= size.height ? ScreenMode.landscape : ScreenMode.portrait;
}

/// A utility class to detect the current platform and runtime conditions.
class DeviceDetector {
  /// True if the app is running on a mobile browser (not a PWA).
  static final bool isMobileBrowser =
      kIsWeb && !isStandalonePWA() && isMobileUserAgent();

  /// True if the app is running on a desktop browser (not a PWA).
  static final bool isDesktopBrowser =
      kIsWeb && !isStandalonePWA() && !isMobileUserAgent();

  /// True if the app is running as a PWA on a mobile device.
  static final bool isPWA_Mobile =
      kIsWeb && isStandalonePWA() && isMobileUserAgent();

  /// True if the app is running as a PWA on a desktop device.
  static final bool isPWA_Desktop =
      kIsWeb && isStandalonePWA() && !isMobileUserAgent();

  /// True if the user requested a desktop site from a mobile browser.
  static final bool isRequestedDeskOnMob =
      kIsWeb && !isMobileUserAgent() && (_size.shortestSide < 600);

  /// True if running as a native Android app.
  static final bool isAndroidNative = isAndroid();

  /// True if running as a native iOS app.
  static final bool isIosNative = isIOS();

  /// True if running as a native Windows app.
  static final bool isWindowsNative = isWindows();

  /// True if running as a native macOS app.
  static final bool isMacOSNative = isMacOS();

  /// True if running as a native Linux app.
  static final bool isLinuxNative = isLinux();

  /// True if running on any mobile platform (native or browser).
  static final bool isMobile = isAndroidNative ||
      isIosNative ||
      isPWA_Mobile ||
      isMobileBrowser ||
      isRequestedDeskOnMob;

  /// True if running on any desktop platform (native or browser).
  static final bool isDesktop = isWindowsNative ||
      isMacOSNative ||
      isDesktopBrowser ||
      isPWA_Desktop ||
      isLinuxNative;
}

/// A widget that renders different UI widgets depending on the platform.
class ScreenerByPlatform extends StatelessWidget {
  /// Widget for Android.
  final Widget? android;

  /// Widget for iOS.
  final Widget? ios;

  /// Widget for Windows.
  final Widget? windows;

  /// Widget for macOS.
  final Widget? macos;

  /// Widget for Linux.
  final Widget? linux;

  /// Widget for any mobile platform.
  final Widget? mobile;

  /// Widget for any desktop platform.
  final Widget? desktop;

  /// Fallback widget if no match is found.
  final Widget? fallback;

  /// Creates a ScreenerByPlatform widget.
  const ScreenerByPlatform({
    super.key,
    this.android,
    this.ios,
    this.windows,
    this.macos,
    this.linux,
    this.mobile,
    this.desktop,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    if (DeviceDetector.isAndroidNative) return android ?? mobile ?? fallback ?? const SizedBox();
    if (DeviceDetector.isIosNative) return ios ?? mobile ?? fallback ?? const SizedBox();
    if (DeviceDetector.isWindowsNative) return windows ?? desktop ?? fallback ?? const SizedBox();
    if (DeviceDetector.isMacOSNative) return macos ?? desktop ?? fallback ?? const SizedBox();
    if (DeviceDetector.isLinuxNative) return linux ?? desktop ?? fallback ?? const SizedBox();
    if (DeviceDetector.isMobile) return mobile ?? fallback ?? const SizedBox();
    if (DeviceDetector.isDesktop) return desktop ?? fallback ?? const SizedBox();
    return fallback ?? const SizedBox();
  }
}

/// A widget that renders one of two child widgets based on screen orientation.
class ScreenerByOrientation extends StatelessWidget {
  /// Widget to show in portrait orientation.
  final Widget portrait;

  /// Widget to show in landscape orientation.
  final Widget landscape;

  /// Creates a ScreenerByOrientation widget.
  const ScreenerByOrientation({
    super.key,
    required this.portrait,
    required this.landscape,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = getScreenMode(context);
    return orientation == ScreenMode.portrait ? portrait : landscape;
  }
}

/// A widget that renders platform and orientation-specific UIs.
class ScreenerByPlatformAndOrientation extends StatelessWidget {
  /// Widget for Android platform based on orientation.
  final Widget Function(BuildContext context, ScreenMode mode)? android;

  /// Widget for iOS platform based on orientation.
  final Widget Function(BuildContext context, ScreenMode mode)? ios;

  /// Widget for Windows platform based on orientation.
  final Widget Function(BuildContext context, ScreenMode mode)? windows;

  /// Widget for macOS platform based on orientation.
  final Widget Function(BuildContext context, ScreenMode mode)? macos;

  /// Widget for Linux platform based on orientation.
  final Widget Function(BuildContext context, ScreenMode mode)? linux;

  /// Fallback widget based on orientation.
  final Widget Function(BuildContext context, ScreenMode mode)? fallback;

  /// Creates a ScreenerByPlatformAndOrientation widget.
  const ScreenerByPlatformAndOrientation({
    super.key,
    this.android,
    this.ios,
    this.windows,
    this.macos,
    this.linux,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final mode = getScreenMode(context);

    if (DeviceDetector.isAndroidNative && android != null) return android!(context, mode);
    if (DeviceDetector.isIosNative && ios != null) return ios!(context, mode);
    if (DeviceDetector.isWindowsNative && windows != null) return windows!(context, mode);
    if (DeviceDetector.isMacOSNative && macos != null) return macos!(context, mode);
    if (DeviceDetector.isLinuxNative && linux != null) return linux!(context, mode);

    return fallback?.call(context, mode) ?? const SizedBox();
  }
}
