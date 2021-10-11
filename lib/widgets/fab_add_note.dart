import 'package:flutter/material.dart';

class FabAddNote extends StatelessWidget {
  VoidCallback onPressed;

  FabAddNote({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
    );
  }
}
