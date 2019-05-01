import 'dart:io';

import 'package:vm_service_lib/vm_service_lib.dart';

Future<VmService> connectService() async {
  final WebSocket ws = await WebSocket.connect('ws://127.0.0.1:9000/ws');

  final VmService service = VmService(
    ws.asBroadcastStream(),
    (String message) {
      print('==> $message');
      ws.add(message);
    },
    log: new Logger(),
  );
  return service;
}

class Logger extends Log {
  @override
  void severe(String message) => print(message);

  @override
  void warning(String message) => print(message);
}
