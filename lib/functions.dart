import 'dart:async';

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
      webSocket.sink.add(message);
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

@CloudFunction()
FutureOr<Response> function(Request request) => handler(request);
