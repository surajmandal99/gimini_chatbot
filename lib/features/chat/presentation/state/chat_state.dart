import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:gemini_chat/core/constants/constants.dart';
import 'package:gemini_chat/core/data/remote/http_service.dart';

class ChatState extends ChangeNotifier {
  final user = ChatUser(
    id: '1',
    firstName: 'Suraj',
    lastName: 'Mandal',
  );

  final aiBot = ChatUser(
    profileImage: 'assets/images/golu_bot.jpg',
    id: '2',
    firstName: 'Gimini',
    lastName: 'AI Bot',
  );

  List<ChatUser> typingUsers = [];

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey! I\'m your Gimini AI Bot. How can I help you today?',
      user: ChatUser(
        profileImage: 'assets/images/golu_bot.jpg',
        id: '2',
        firstName: 'Gimini',
        lastName: 'AI Bot',
      ),
      createdAt: DateTime.now(),
    ),
  ];

  Future<void> onSend(ChatMessage message) async {
    typingUsers.add(aiBot);
    messages.insert(0, message);
    notifyListeners();

    var data = {
      "contents": [
        {
          "parts": [
            {
              "text": message.text,
            }
          ]
        }
      ]
    };

    await HttpService()
        .post(AppString.geminiAPIBaseUrl, jsonEncode(data), passToken: false)
        .then((value) {
      if (value != null) {
        ChatMessage botMessage = ChatMessage(
          user: aiBot,
          text: value['candidates'][0]['content']['parts'][0]['text'],
          createdAt: DateTime.now(),
        );

        messages.insert(0, botMessage);
      }
    });

    typingUsers.remove(aiBot);

    notifyListeners();
  }
}
