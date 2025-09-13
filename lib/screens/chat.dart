import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "package:flutter_chat_app/widgets/chat_messages.dart";
import "package:flutter_chat_app/widgets/new_message.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void enablePushNotifications() async {
    final firebase = FirebaseMessaging.instance;
    await firebase.requestPermission();

    final token = await firebase.getToken();
    print("Firebase Messaging Token: $token");
  }

  @override
  void initState() {
    super.initState();

    enablePushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Flutter Chat"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: ChatMessages()),
          NewMessage(),
        ],
      ),
    );
  }
}
