import 'package:flutter_test/flutter_test.dart';
import 'package:habit/flutter_habit.dart';
import 'package:habit/flutter_habit_platform_interface.dart';
import 'package:habit/flutter_habit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterHabitPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterHabitPlatform {

  @override
  Future<String> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterHabitPlatform initialPlatform = FlutterHabitPlatform.instance;

  test('$MethodChannelFlutterHabit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterHabit>());
  });

  test('getPlatformVersion', () async {
    FlutterHabit flutterHabitPlugin = FlutterHabit();
    MockFlutterHabitPlatform fakePlatform = MockFlutterHabitPlatform();
    FlutterHabitPlatform.instance = fakePlatform;
  
    expect(await flutterHabitPlugin.getPlatformVersion(), '42');
  });
}
