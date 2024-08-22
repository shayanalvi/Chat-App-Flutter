import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    //get auth service

    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUseresStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return Text("error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          //return list
          return ListView(
            children: [],
          );
        });
  }
}
