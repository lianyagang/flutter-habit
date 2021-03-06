// Autogenerated from Pigeon (v0.1.17), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class VVFlutterRouterParam;

@interface VVFlutterRouterParam : NSObject
@property(nonatomic, copy, nullable) NSString * path;
@property(nonatomic, strong, nullable) NSDictionary * params;
@end

@protocol VVFlutterRouterManager
-(void)notifyNavigatorPath:(VVFlutterRouterParam*)input error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void VVFlutterRouterManagerSetup(id<FlutterBinaryMessenger> binaryMessenger, id<VVFlutterRouterManager> _Nullable api);

NS_ASSUME_NONNULL_END
