/// Copyright 2020 Dylan <wangbo4020@gmail.com>
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

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
