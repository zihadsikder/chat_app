import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// chat & auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'search...',
                  labelStyle: TextStyle(color: Colors.grey.shade500),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  /// build a list of user expect for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          ///error
          if (snapshot.hasError) {
            return const Center(child: Text('Error...!'));
          }

          /// loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// return list view
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList(),
            );
          } else {
            return const Center(child: Text('No users found'));
          }
        });
  }

  /// build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    /// display all user except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          /// tapped to a user -> go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
