import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.tealAccent,
    );
  }
}