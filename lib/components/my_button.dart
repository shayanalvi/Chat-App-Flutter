import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap; // Callback function for tap events

  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the onTap callback when the button is tapped
      child: Container(
        width: double.infinity, // Full width button
        margin: EdgeInsets.symmetric(horizontal: 24), // Horizontal margin
        padding: EdgeInsets.symmetric(vertical: 12), // Padding inside the button
        decoration: BoxDecoration(
          color: Colors.blue, // Button background color
          borderRadius: BorderRadius.circular(30), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4), // Shadow color
              spreadRadius: 2, // Spread radius of the shadow
              blurRadius: 5, // Blur radius of the shadow
              offset: Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            text, // Use the string text here
            style: TextStyle(
              color: Colors.white, // Text color
              fontSize: 18, // Font size
              fontWeight: FontWeight.bold, // Bold text
            ),
          ),
        ),
      ),
    );
  }
}
