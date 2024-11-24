import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

abstract final class AppPlatform {
  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;

  static Future<int> currentAndroidSdkVersion() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    final androidInfo = await deviceInfoPlugin.androidInfo;

    return androidInfo.version.sdkInt;
  }
}
