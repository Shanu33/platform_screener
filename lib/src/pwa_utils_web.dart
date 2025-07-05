import 'dart:html' as html;
import 'package:js/js_util.dart' as js_util;

bool isStandalonePWA() {
  try {
    final isStandaloneViaMediaQuery =
        html.window
            .matchMedia('(display-mode: standalone)')
            .matches; //for Android Web app

    // Use js_util to safely access non-standard web property
    final isStandaloneViaNavigator =
        js_util.getProperty(html.window.navigator, 'standalone') == true; // for iOS web app

    return isStandaloneViaMediaQuery || isStandaloneViaNavigator;
  } catch(e){
    return false; // if on browser
  }
}
bool isMobileUserAgent() {

  try{
  final ua = html.window.navigator.userAgent.toLowerCase();
  return ua.contains('iphone') ||
      ua.contains('android') ||
      ua.contains('ipad') ||
      ua.contains('mobile');  // "mobile" covers many fallback cases
    }
    catch(_){
      return false;
    }
}