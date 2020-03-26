import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/models/user.dart';
import 'package:artem_app/custom_flutter/custom_dialog.dart' as customDialog;

class UpdateInfoDialog extends StatefulWidget {
  final User user;

  UpdateInfoDialog({Key key, @required this.user});

  @override
  _UpdateInfoDialogState createState() => _UpdateInfoDialogState(user: user);
}

class _UpdateInfoDialogState extends State<UpdateInfoDialog> {
  final User user;
  final _schools = ["Ensad", "ICN", "Mines"];
  String _currentSelectedSchool;
  String _currentSelectedUnion;
  List<DropdownMenuItem<String>> _dropDownSchoolItems = [];
  List<DropdownMenuItem<String>> _dropDownUnionItems = [];

  @override
  void initState() {
    super.initState();
    for (String item in _schools) {
      _dropDownSchoolItems.add(
        DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
        ),
      );
    }
  }

//  void _updateDropDownUnionItems(String school){
//  }

  _UpdateInfoDialogState({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {
    return customDialog.AlertDialog(
//      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
//        margin: EdgeInsets.all(0),
//        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//                border: Border.all(color: Colors.black)),
        child: Form(
          key: null,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(user.firstName + " " + user.lastName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Text(
                      user.email,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.school, color: Colors.blue),
                    SizedBox(width: 20),
                    Text(
                      "École",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.width * 0.15,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
//                              labelStyle: textStyle,
                              errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 5.0),
                              hintText: "Choisir une école",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            isEmpty: _currentSelectedSchool == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _currentSelectedSchool,
                                isDense: false,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedSchool = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _dropDownSchoolItems,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Promotion d'entrée",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextFormField(
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            hintText: "2019, 2020...",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      )
                    ]),
                SizedBox(height: 20),
                Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Association(s)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.width * 0.15,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return _currentSelectedSchool == null
                              ? InputDecorator(
                              decoration: InputDecoration(
                                hintText: "Choisir une asso",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide:  BorderSide(color: Colors.grey[200], width: 0.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              isEmpty: true)
                              : InputDecorator(
                            decoration: InputDecoration(
//                              labelStyle: textStyle,
                              errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 5.0),
                              hintText: "Choisir une asso",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            isEmpty: _currentSelectedUnion == null,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _currentSelectedUnion,
                                isDense: false,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _currentSelectedUnion = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _dropDownUnionItems,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  icon: Icon(
                    Icons.save_alt,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Enregistrer les modifications",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}