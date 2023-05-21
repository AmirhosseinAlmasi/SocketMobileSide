import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class chat extends ChangeNotifier {
  List<String> _msgList = [];
  List<String> get msgList => _msgList;
  late IO.Socket socket;

  initSocket() {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }
  chat(){
    initSocket();
    receiveMessage();
  }

  receiveMessage() {
    socket.on('chat message', (newMessage) {
      _msgList.add(newMessage);
      notifyListeners();
    });
  }

  sendMessage(String str) {
    String message = str;
    if (message.isEmpty) return;
    socket.emit('chat message', str);
  }

}
