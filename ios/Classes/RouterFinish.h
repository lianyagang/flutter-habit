// Autogenerated from Pigeon (v0.1.17), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN


@protocol VVRouterFinishManager
-(void)notifyFinishCurrentPage:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void VVRouterFinishManagerSetup(id<FlutterBinaryMessenger> binaryMessenger, id<VVRouterFinishManager> _Nullable api);

NS_ASSUME_NONNULL_END
