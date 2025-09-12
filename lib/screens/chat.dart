import "package:flutter/material.dart";

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Flutter Chat")),
      body: Center(child: Text("This is the chat screen.")),
    );
  }
}
