import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_habit_method_channel.dart';

abstract class FlutterHabitPlatform extends PlatformInterface {
  /// Constructs a FlutterHabitPlatform.
  FlutterHabitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterHabitPlatform _instance = MethodChannelFlutterHabit();

  /// The default instance of [FlutterHabitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterHabit].
  static FlutterHabitPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterHabitPlatform] when
  /// they register themselves.
  static set instance(FlutterHabitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
