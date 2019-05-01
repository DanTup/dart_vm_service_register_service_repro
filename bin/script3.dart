import 'dart:io';

import 'package:foo/shared.dart';
import 'package:vm_service_lib/vm_service_lib.dart';

const doThingService = 'doThing';

Future<void> main() async {
  VmService service = await connectService();

  service.registerServiceCallback(doThingService, (params) async {
    if (params != null && params['fail'] == true) {
      return {
        //'result': 'anything'
        'result': {'type': 'Failure'}
      };
    } else {
      return {'result': Success().toJson()};
    }
  });

  print('Registering doThing service!');
  await service.registerService(doThingService, 'Danny Test');
}
