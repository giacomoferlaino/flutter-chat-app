import 'package:flutter/material.dart';

class MessageBuggle extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  MessageBuggle({
    @required this.message,
    @required this.username,
    @required this.userImage,
    @required this.isMe,
    @required this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      isMe ? Colors.grey[400] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline6
                                  .color,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline6
                                  .color,
                        ),
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                      ),
                    ]),
              ),
            ],
          ),
          Positioned(
            top: -10,
            right: isMe ? 120 : null,
            left: isMe ? null : 120,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
