import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  /// text controller
  final TextEditingController _messageController = TextEditingController();

  /// chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  /// send message
  void sendMessage() async {
    /// if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      /// clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          /// display all message
          Expanded(
            child: _buildMessageList(),
          ),

          /// user input
          _buildUserInput(),
        ],
      ),
    );
  }

  /// build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessage(receiverID, senderID),
        builder: (context, snapshot) {
          /// error
          if (snapshot.hasError) {
            return const Center(child: Text('Error...!'));
          }

          /// loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// return list view
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  /// build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    /// is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    /// align message to the right if sender is the current user, otherwise left
    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: aligment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
          ],
        ));
  }

  /// build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0),
      child: Row(
        children: [
          /// textfield should take up most of the space
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
            ),
          ),

          /// send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
