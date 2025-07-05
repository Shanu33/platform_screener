// screener.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'src/platform_utils.dart';
import 'src/pwa_utils.dart';

var _size;

enum ScreenMode { portrait, landscape }
ScreenMode getScreenMode(BuildContext context) {
  final size = _size = MediaQuery.of(context).size;
  return size.width >= size.height ? ScreenMode.landscape : ScreenMode.portrait;
}

class deviceDetector {
  static final bool isMobileBrowser =
      kIsWeb && !isStandalonePWA() && isMobileUserAgent();
  static final bool isDesktopBrowser =
      kIsWeb && !isStandalonePWA() && !isMobileUserAgent();

  static final bool isPWA_Mobile =
      kIsWeb && isStandalonePWA() && isMobileUserAgent();
  static final bool isPWA_Desktop =
      kIsWeb && isStandalonePWA() && !isMobileUserAgent();
  static final bool isRequestedDeskOnMob =
      kIsWeb && !isMobileUserAgent() && (_size.shortestSide < 600);

  static final bool isAndroidNative = isAndroid();
  static final bool isIosNative = isIOS();
  static final bool isWindowsNative = isWindows();
  static final bool isMacOSNative = isMacOS();
  static final bool isLinuxNative = isLinux();

  static final bool isMobile = isAndroidNative ||
      isIosNative ||
      isPWA_Mobile ||
      isMobileBrowser ||
      isRequestedDeskOnMob;

  static final bool isDesktop = isWindowsNative ||
      isMacOSNative ||
      isDesktopBrowser ||
      isPWA_Desktop ||
      isLinuxNative;
}

// Widget-based Platform Rendering
class ScreenerByPlatform extends StatelessWidget {
  final Widget? android;
  final Widget? ios;
  final Widget? windows;
  final Widget? macos;
  final Widget? linux;
  final Widget? mobile;
  final Widget? desktop;
  final Widget? fallback;

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
    if (deviceDetector.isAndroidNative) return android ?? mobile ?? fallback ?? const SizedBox();
    if (deviceDetector.isIosNative) return ios ?? mobile ?? fallback ?? const SizedBox();
    if (deviceDetector.isWindowsNative) return windows ?? desktop ?? fallback ?? const SizedBox();
    if (deviceDetector.isMacOSNative) return macos ?? desktop ?? fallback ?? const SizedBox();
    if (deviceDetector.isLinuxNative) return linux ?? desktop ?? fallback ?? const SizedBox();
    if (deviceDetector.isMobile) return mobile ?? fallback ?? const SizedBox();
    if (deviceDetector.isDesktop) return desktop ?? fallback ?? const SizedBox();
    return fallback ?? const SizedBox();
  }
}

class ScreenerByOrientation extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;

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

class ScreenerByPlatformAndOrientation extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenMode mode)? android;
  final Widget Function(BuildContext context, ScreenMode mode)? ios;
  final Widget Function(BuildContext context, ScreenMode mode)? windows;
  final Widget Function(BuildContext context, ScreenMode mode)? macos;
  final Widget Function(BuildContext context, ScreenMode mode)? linux;
  final Widget Function(BuildContext context, ScreenMode mode)? fallback;

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

    if (deviceDetector.isAndroidNative && android != null) return android!(context, mode);
    if (deviceDetector.isIosNative && ios != null) return ios!(context, mode);
    if (deviceDetector.isWindowsNative && windows != null) return windows!(context, mode);
    if (deviceDetector.isMacOSNative && macos != null) return macos!(context, mode);
    if (deviceDetector.isLinuxNative && linux != null) return linux!(context, mode);

    return fallback?.call(context, mode) ?? const SizedBox();
  }
}
