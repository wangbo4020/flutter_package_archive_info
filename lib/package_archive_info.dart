import 'dart:async';

import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

/// Application metadata. Provides .apk package information on Android.
/// Non-support .ipa
///
/// ```dart
/// PackageInfo packageInfo = await PackageArchiveInfo.fromPath('File path.apk')
/// print("Version is: ${packageInfo.version}");
/// ```
class PackageArchiveInfo extends PackageInfo {
  /// Constructs an instance with the given values for testing. [PackageArchiveInfo]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  ///
  /// See [fromPath] for the right API to get a [PackageArchiveInfo] that's
  /// actually populated with real data.
  PackageArchiveInfo({
    String appName,
    String packageName,
    String version,
    String buildNumber,
  }) : super(
          appName: appName,
          packageName: packageName,
          version: version,
          buildNumber: buildNumber,
        );

  static const MethodChannel _channel =
      const MethodChannel('com.wangbo4020/package_archive_info');

  /// Retrieves package information from the local file.
  static Future<PackageArchiveInfo> fromPath(String path) {
    return _channel.invokeMapMethod('getPackageArchiveInfo', {
      "archiveFilePath": path,
    }).then<PackageArchiveInfo>((map) {
      return PackageArchiveInfo(
        appName: map["appName"],
        packageName: map["packageName"],
        version: map["version"],
        buildNumber: map["buildNumber"],
      );
    });
  }
}
