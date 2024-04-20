import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Models/RecieveMessageModel.dart';
import 'package:user_app/Providers/AuthProvider.dart';

import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  late IOWebSocketChannel ws;
  String message = '';

  final _user = const types.User(
    id: 'CUSTOMER',
  );

  @override
  void initState() {
    super.initState();
    ConnectWebSocket();
  }

  @override
  void dispose(){
    
  }

  void ConnectWebSocket() async {
    try {
      String token = context.read<AuthProvider>().getUserInfo().token;
      ws = IOWebSocketChannel.connect(
          Uri.parse(
              '${dotenv.env['WS_BASEURL']!}/${dotenv.env['API_VERSION']}/chats/${dotenv.env['TEST_CHATID']}'),
          headers: {
            'Authorization': 'Bearer ${dotenv.env['TEST_TOKEN']}',
          });

      ws.stream.listen(
        (message) {
          RecieveMessageModel reMessage = RecieveMessageModel.fromJson(
              jsonDecode(message) as Map<String, dynamic>);

          if (reMessage.chatSender != "SYSTEM") {
            final textMessage = types.TextMessage(
              author: types.User(id: reMessage.chatSender),
              createdAt: DateTime.now().millisecondsSinceEpoch,
              id: const Uuid().v4(),
              text: reMessage.Message,
            );
            _addMessage(textMessage);
          }
        },
        onError: (error) async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        onDone: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text("Connection error"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    ws.sink.add(message.text);
    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: _user,
        theme: const DefaultChatTheme(
          seenIcon: Text(
            'read',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
