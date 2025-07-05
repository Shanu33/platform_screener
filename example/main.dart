import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:adaptive_linear_layout/adaptive_linear_layout.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:learning_things2/screener.dart';
import 'package:learning_things2/platform_utils.dart'; // If used directly

void main() {
  runApp(const MyApp());

  // For testing with DevicePreview (optional):
  /*
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenMode = getScreenMode(context);
    final isLandscape = screenMode == ScreenMode.landscape;

    final platform = deviceDetector.isAndroidNative
        ? 'Android'
        : deviceDetector.isIosNative
            ? 'iOS'
            : deviceDetector.isPWA_Desktop
                ? 'PWA Desktop'
                : deviceDetector.isPWA_Mobile
                    ? 'PWA Mobile'
                    : deviceDetector.isDesktop
                        ? 'Desktop'
                        : deviceDetector.isMobile
                            ? 'Mobile Web'
                            : 'Unknown';

    return Scaffold(
      appBar: AppBar(title: const Text('Truly Responsive App')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: FlexLinearLayout(
            context: context,
            layoutPreference: isLandscape ? LayoutPreference.row : LayoutPreference.column,
            spacing: 20,
            children: [
              SvgPicture.asset(
                "assets/Image/google_icon.svg",
                width: isLandscape ? 100 : 60,
                height: isLandscape ? 100 : 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Running on: $platform',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Screen: ${screenSize.width.toStringAsFixed(1)} x ${screenSize.height.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    isLandscape ? 'Landscape Mode' : 'Portrait Mode',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
