import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No messages found."));
        }

        if (snapshot.hasError) {
          return Center(child: Text("An error occurred. Please try again."));
        }

        final chatDocs = snapshot.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40, left: 13, right: 13, top: 10),
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, idx) {
            return Text(chatDocs[idx].data()["message"]);
          },
        );
      },
    );

    //return Center(child: Text("This is the chat messages widget."));
  }
}
