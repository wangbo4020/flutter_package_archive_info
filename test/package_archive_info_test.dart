import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_archive_info/package_archive_info.dart';

void main() {
  const MethodChannel channel = MethodChannel('package_archive_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPackageArchiveInfo', () async {
    expect(await PackageArchiveInfo.fromPath('your path'), '42');
  });
}
