import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_habit_platform_interface.dart';

/// An implementation of [FlutterHabitPlatform] that uses method channels.
class MethodChannelFlutterHabit extends FlutterHabitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_habit');

  @override
  Future<String> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
