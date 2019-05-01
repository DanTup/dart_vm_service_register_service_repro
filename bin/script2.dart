import 'dart:convert';

import 'package:foo/shared.dart';
import 'package:vm_service_lib/vm_service_lib.dart';

const doThingService = 'doThing';

Future<void> main() async {
  VmService service = await connectService();

  await service.streamListen('_Service');
  print('Waiting for service event!');

  service.onServiceEvent.listen((e) async {
    if (e.kind == 'ServiceRegistered' && e.service == 'doThing') {
      print('Got service event!');
      print('');
      await Future.delayed(const Duration(seconds: 1));

      print('Calling to return success!');
      final res1 = await service.callMethod(e.method);
      print('Got: ${res1.type}, ${jsonEncode(res1.json)}');

      print('');
      await Future.delayed(const Duration(seconds: 1));

      print('Got service event, calling to return something else!');
      final res2 = await service.callMethod(e.method, args: {'fail': true});
      print('Got: ${res2.type}, ${jsonEncode(res2.json)}');
    }
  });
}
