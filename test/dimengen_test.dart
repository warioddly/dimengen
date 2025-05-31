import 'package:flutter_test/flutter_test.dart';
import 'package:dimengen/dimengen.dart';
import 'package:dimengen/dimengen_platform_interface.dart';
import 'package:dimengen/dimengen_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDimengenPlatform
    with MockPlatformInterfaceMixin
    implements DimengenPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DimengenPlatform initialPlatform = DimengenPlatform.instance;

  test('$MethodChannelDimengen is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDimengen>());
  });

  test('getPlatformVersion', () async {
    Dimengen dimengenPlugin = Dimengen();
    MockDimengenPlatform fakePlatform = MockDimengenPlatform();
    DimengenPlatform.instance = fakePlatform;

    expect(await dimengenPlugin.getPlatformVersion(), '42');
  });
}
