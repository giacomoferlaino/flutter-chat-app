import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  final Stream<QuerySnapshot> _messagesStream;

  Messages(this._messagesStream);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messagesStream,
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final List<QueryDocumentSnapshot> chatDocs =
            chatSnapshot.data.documents;
        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (context, index) => MessageBuggle(
            message: chatDocs[index].get('text'),
            username: chatDocs[index].get('username'),
            userImage: chatDocs[index].get('userImage'),
            isMe: chatDocs[index].get('userId') ==
                FirebaseAuth.instance.currentUser.uid,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
