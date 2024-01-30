import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/chat_state.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Gimini Ai Bot'),
          centerTitle: true),
      body: Consumer<ChatState>(
        builder: (context, state, child) {
          return DashChat(
            typingUsers: state.typingUsers,
            currentUser: state.user,
            onSend: state.onSend,
            messages: state.messages,
          );
        },
      ),
    );
  }
}
