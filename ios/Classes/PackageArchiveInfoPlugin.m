#import "PackageArchiveInfoPlugin.h"
#if __has_include(<package_archive_info/package_archive_info-Swift.h>)
#import <package_archive_info/package_archive_info-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "package_archive_info-Swift.h"
#endif

@implementation PackageArchiveInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPackageArchiveInfoPlugin registerWithRegistrar:registrar];
}
@end
