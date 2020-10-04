import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:artem_app/layouts/event/image_picker.dart';
import 'package:artem_app/layouts/event/date_time_picker.dart';
import '../../services/models/user.dart';
import '../../services/models/role.dart';
import '../../services/models/event.dart';
import '../../services/models/union.dart';

class AddEvent extends StatefulWidget {
  final User user;
  final Event eventToBeEdited;

  AddEvent({Key key, @required this.user, this.eventToBeEdited});

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController titleController;
  String title;
  File image;
  Union union;
  DateTime startDate;
  DateTime endDate;
  String place;
  String description;

  Event event;

  void getPickedImage(pickedImage) {
    image = pickedImage;
  }

  void getPickedUnion(String unionName) {
    for (Role role in widget.user.roles) {
      if (role.union.name == unionName) {
        union = role.union;
      }
    }
  }

  void getStartPickedDateTime(pickedDateTime) {
    startDate = pickedDateTime;
  }

  void getEndPickedDateTime(pickedDateTime) {
    endDate = pickedDateTime;
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
        text: widget.eventToBeEdited?.name
    );
  }

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
                      controller: titleController,
//                      initialValue: widget.eventToBeEdited?.name,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        isDense: false,
                        hintText: "Soirée...",
                        labelText: "Nom de l'évènement",
                        alignLabelWithHint: true,
                      ),
                      onFieldSubmitted: (String value) {
                        title = value;
                        titleController.text = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: MyImagePicker(
                      getPickedImage: getPickedImage,
                      initialPickedImage: widget.eventToBeEdited?.image,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropDownMenu(
                      roles: widget.user.roles,
                      getUnionName: getPickedUnion,
                      unionToBeEdited: widget.eventToBeEdited?.union,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 8, right: 8),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.event, color: Colors.pink),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            children: <Widget>[
                              DateTimePicker(
                                pickerLabel: "Début : date et heure",
                                getPickedDateTime: getStartPickedDateTime,
                                initialDateTime:
                                    widget.eventToBeEdited?.timeStart,
                              ),
                              DateTimePicker(
                                pickerLabel: "Fin : date et heure",
                                getPickedDateTime: getStartPickedDateTime,
                                initialDateTime:
                                    widget.eventToBeEdited?.timeEnd,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.eventToBeEdited?.place,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.pink,
                          ),
                          hintText: "Campus Artem...",
                          labelText: "Lieu",
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(color: Colors.grey)),
                      onSaved: (String value) {},
                      onFieldSubmitted: (String value) {
                        place = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.eventToBeEdited?.description,
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                  widget.eventToBeEdited == null
                      ? Icons.add_box
                      : Icons.save_alt,
                  color: Colors.white,
                ),
                label: Text(
                  widget.eventToBeEdited == null
                      ? "Créer"
                      : "Sauvegarder les modifications",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  event = Event(
                    union: union,
                    name: title,
                    timeStart: startDate,
                    timeEnd: endDate,
                    place: place,
                    description: description,
                    image: image,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownMenu extends StatefulWidget {
  final List<Role> roles;
  final void Function(String unionName) getUnionName;
  final Union unionToBeEdited;

  DropDownMenu({
    Key key,
    @required this.roles,
    @required this.getUnionName,
    this.unionToBeEdited,
  });

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  List<DropdownMenuItem<String>> _dropDownUnionItems = [];
  String _currentSelectedUnionName;

  @override
  void initState() {
    _currentSelectedUnionName = widget.unionToBeEdited?.name;
    super.initState();
    for (Role role in widget.roles) {
      if (role.canPublish) {
        _dropDownUnionItems.add(
          DropdownMenuItem<String>(
            value: role.union.name,
            child: Text(
              role.union.name,
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.15,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
//                              labelStyle: textStyle,
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 5.0),
              hintText: "Choisir une asso",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            isEmpty: _currentSelectedUnionName == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentSelectedUnionName,
                isDense: false,
                onChanged: (String newValue) {
                  setState(
                    () {
                      _currentSelectedUnionName = newValue;
                      state.didChange(newValue);
                      widget.getUnionName(newValue);
                    },
                  );
                },
                items: _dropDownUnionItems,
              ),
            ),
          );
        },
      ),
    );
  }
}
