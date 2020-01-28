import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/BlurArtem.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}