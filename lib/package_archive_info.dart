import 'dart:async';

import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class PackageArchiveInfo extends PackageInfo {

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
