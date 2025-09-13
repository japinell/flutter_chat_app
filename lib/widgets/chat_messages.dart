import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "package:flutter_chat_app/widgets/message_bubble.dart";

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

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
            final message = chatDocs[idx].data();
            final nextMessage = idx + 1 < chatDocs.length
                ? chatDocs[idx + 1].data()
                : null;
            final currentUserId = message["userId"];
            final nextUserId = nextMessage != null
                ? nextMessage["userId"]
                : null;
            final isSameUser = currentUserId == nextUserId;

            if (isSameUser) {
              return MessageBubble.next(
                message: message["message"],
                isMe: user.uid == currentUserId,
              );
            } else {
              return MessageBubble.first(
                userImage: message["userImage"],
                username: message["username"],
                message: message["message"],
                isMe: user.uid == currentUserId,
              );
            }
          },
        );
      },
    );

    //return Center(child: Text("This is the chat messages widget."));
  }
}
