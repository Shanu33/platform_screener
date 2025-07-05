import 'dart:io';
import 'package:flutter/foundation.dart';

bool isAndroid() => !kIsWeb && Platform.isAndroid;
bool isIOS() =>!kIsWeb &&  Platform.isIOS;
bool isWindows() => !kIsWeb && Platform.isWindows;
bool isMacOS() => !kIsWeb && Platform.isMacOS;
bool isLinux() => !kIsWeb && Platform.isLinux;
