import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class CrousInfoWidget extends StatelessWidget {
	final String name;

	CrousInfoWidget(this.name);

	@override
	Widget build(BuildContext context) {
		final auth = AuthService();
		auth.login('a.bouzigues@outlook.fr', 'SLGHNPFV');
		return Container(
	    color: Colors.blue,
		    child: Text('CrousInfoWidget')
	    );
  }
}
