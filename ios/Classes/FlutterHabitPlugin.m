#import "FlutterHabitPlugin.h"
#if __has_include(<flutter_habit/flutter_habit-Swift.h>)
#import <flutter_habit/flutter_habit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_habit-Swift.h"
#endif

@implementation FlutterHabitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterHabitPlugin registerWithRegistrar:registrar];
}
@end
