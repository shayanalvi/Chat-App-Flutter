import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String receiverID;
  ChatPage({super.key, required this.reciverEmail, required this.receiverID});

  // Text controller
  final TextEditingController _messageController = TextEditingController();

  // Chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Send message
  void sendMessage() async {
    // If there is something inside the text field
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      // Clear controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reciverEmail),
      ),
      body: Column(
        // Display all messages
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(), // Added the input field here
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrenUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return Text("Error");
        }

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        // Return list view
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) {
            return _buildMessageItem(doc);
          }).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Check if the message is from the current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrenUser()!.uid;

    // Align message to the right if the sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
          // Text(data['message']),
        ],
      ),
    );
  }

  // Build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // Text input field
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Enter your message...',
              ),
            ),
          ),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.black,
              ),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
