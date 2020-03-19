import 'package:artem_app/layouts/common/loader.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class CrousInfoWidget extends StatelessWidget {
	List <Widget> crousInfoList;

	void getCrousInfo () {


	}


	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(
				title: Text("Informations sur le campus Artem"),
			),
			body: Column(
				children: <Widget>[],
			),
		);
  }
}
