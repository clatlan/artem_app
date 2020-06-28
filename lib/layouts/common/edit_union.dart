import 'package:flutter/material.dart';
import 'dart:io';

import 'package:artem_app/layouts/event/image_picker.dart';
import 'package:artem_app/services/models/union.dart';

class EditUnion extends StatefulWidget {
  final Union union;

  EditUnion({Key key, @required this.union});

  _EditUnionState createState() => _EditUnionState();
}

class _EditUnionState extends State<EditUnion> {
  String description;
  File image;
  File logo;

  void getPickedImage(pickedImage) {
    image = pickedImage;
  }

  void getPickedLogo(pickedLogo) {
    logo = pickedLogo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Modifier la page",
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                    child: MyImagePicker(
                      getPickedImage: getPickedImage,
//            initialPickedImage: widget.union?.image,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      margin: const EdgeInsets.symmetric(horizontal: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                        child: Container(
//                          margin: const EdgeInsets.only(bottom: 6.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 0.1, color: Colors.grey),
                          ),
                          child: MyImagePicker(
                            getPickedImage: getPickedLogo,
                            label: "Ajouter un logo",
//            initialPickedImage: widget.union?.image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.union?.description,
                      maxLength: 1200,
                      maxLines: null,
                      style: TextStyle(color: Colors.blue, height: 1.2),
                      decoration: InputDecoration(
                        isDense: false,
                        icon: Icon(
                          Icons.create,
                          color: Colors.pink,
                        ),
                        labelText: "Description",
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      onFieldSubmitted: (String value) {
                        description = value;
                      },
//                          validator: (String value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                elevation: 1.0,
                icon: Icon(
                  Icons.save_alt,
                  color: Colors.white,
                ),
                label: Text(
                  "Sauvegarder les modifications",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
