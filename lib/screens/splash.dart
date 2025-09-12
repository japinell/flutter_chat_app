import "package:flutter/material.dart";

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Flutter Chat")),
      body: Center(child: Text("Loading...")),
    );
  }
}
