import 'dart:async';

import 'package:analysis_server_lib/analysis_server_lib.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Assumptions
/// -
final handler = webSocketHandler((WebSocketChannel webSocket) {
  // Now attach a listener to the websocket that will perform the ongoing logic
  webSocket.stream.listen(
    (message) {
      // final jsonData = jsonDecode(message);
      webSocket.sink.add(message + versionResult!.version);
    },
    onError: (error) {
      print(error);
      webSocket.sink.add('$error');
    },
    onDone: () {
      // when we add each websocket to a local data structure we can remove them here
    },
  );
});

AnalysisServer? analysisServer;
VersionResult? versionResult;

@CloudFunction()
FutureOr<Response> function(Request request) async {
  try {
    analysisServer ??= await AnalysisServer.create();
    final analysis = analysisServer!;
    await analysis.server.onConnected.first;

    versionResult ??= await analysis.server.getVersion();

    return handler(request);
  } catch (error, trace) {
    print(trace);
    return Response.internalServerError(body: error);
  }
}
