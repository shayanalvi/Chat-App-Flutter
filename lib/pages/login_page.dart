import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //email and pw text controllers

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to go to register page

  final Function()? onTap;


  LoginPage({super.key, required this.onTap});

  void login( BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }

    //catch error
    catch(e) {
      showDialog(context: context, builder: builder)

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),

            //welccome back
            Text(
              "Welcome back, you have been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            //email textfield
            MyTextfield(
              controller: _emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),

            //passowrd

            MyTextfield(
              controller: _pwController,
              hintText: "Password",
              obscureText: true,
            ),

            const SizedBox(
              height: 25,
            ),

            MyButton(
              text: "Login",
              onTap: login,
            ),

            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
