#import "HabitPlugin.h"
#if __has_include(<habit/habit-Swift.h>)
#import <habit/habit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "habit-Swift.h"
#endif

@implementation HabitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHabitPlugin registerWithRegistrar:registrar];
}
@end
