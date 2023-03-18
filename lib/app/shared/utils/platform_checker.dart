import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Util {
  OpSys getPlatform() {
    if (kIsWeb) {
      return OpSys.web;
    } else if (Platform.isIOS) {
      return OpSys.iOS;
    } else if (Platform.isAndroid) {
      return OpSys.android;
    } else if (Platform.isFuchsia) {
      return OpSys.fuchsia;
    } else if (Platform.isLinux) {
      return OpSys.linux;
    } else if (Platform.isMacOS) {
      return OpSys.macOS;
    } else if (Platform.isWindows) {
      return OpSys.windows;
    }
    return OpSys.unknown;
  }

  bool isWeb() {
    return (getPlatform() == OpSys.web);
  }

  bool isMobile() {
    OpSys platform = getPlatform();
    return (platform == OpSys.android ||
        platform == OpSys.iOS ||
        platform == OpSys.fuchsia);
  }

  bool isComputer() {
    OpSys platform = getPlatform();
    return (platform == OpSys.linux ||
        platform == OpSys.macOS ||
        platform == OpSys.windows);
  }
}

enum OpSys { unknown, web, android, fuchsia, iOS, linux, macOS, windows }
