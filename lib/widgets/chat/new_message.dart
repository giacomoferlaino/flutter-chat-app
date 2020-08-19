import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final User user = FirebaseAuth.instance.currentUser;
    final dynamic userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _messageController.text,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Send message'),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed:
                _messageController.text.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
