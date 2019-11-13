import 'package:flutter/material.dart';

class CrousInfoWidget extends StatelessWidget {
	final String name;

	CrousInfoWidget(this.name);

	@override
	Widget build(BuildContext context) {
    return Container(
	    color: Colors.blue,
		    child: Text('CrousInfoWidget')
	    );
  }
}
