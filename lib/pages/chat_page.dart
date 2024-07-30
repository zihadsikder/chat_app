import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  /// text controller
  final TextEditingController _messageController = TextEditingController();

  /// chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  /// for textfiled focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    /// add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        /// cause a delay so that the keyboard has time to show up
        /// then the amount of remainu=ing space will be calculate,
        /// the scroll dowm
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    /// wait a bit for listview to be built, then scroll to bottom
    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  /// scroll controller
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  /// send message
  void sendMessage() async {
    /// if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      /// clear text controller
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiverEmail),
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
        stream: _chatService.getMessage(widget.receiverID, senderID),
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
            //reverse: true,   // Show the newest messages at the bottom
            controller: _scrollController,
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
              focusNode: myFocusNode,
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
