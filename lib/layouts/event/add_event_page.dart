import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:artem_app/layouts/event/image_picker.dart';
import 'package:artem_app/layouts/event/date_time_picker.dart';


class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Créer un évènement",
//          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: Form(
              key: null,
              child: ListView(
                shrinkWrap: false,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        isDense: false,
                        hintText: "Soirée",
                        labelText: "Nom de l'évènement",
                        alignLabelWithHint: true,
                      ),
                      onSaved: (String value) {},
                      validator: (String value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyImagePicker(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.event, color: Colors.pink),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            children: <Widget>[
                              DateTimePicker("Début : date et heure"),
                              DateTimePicker("Fin : date et heure"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.blue),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.pink,
                          ),
                          hintText: "Campus Artem...",
                          labelText: "Lieu",
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(color: Colors.grey)),
                      onSaved: (String value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLength: 500,
                      maxLines: null,
                      style: TextStyle(color: Colors.blue, height: 1),
                      decoration: const InputDecoration(
                        isDense: false,
                        icon: Icon(
                          Icons.create,
                          color: Colors.pink,
                        ),
                        labelText: "Description",
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      onSaved: (String value) {},
//                          validator: (String value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: RaisedButton.icon(
                shape:RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),),
                elevation: 1.0,
                icon: Icon(
                  Icons.add_box,
                  color: Colors.white,
                ),
                label: Text("Créer", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
