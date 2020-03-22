import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String datePickerLabel;

  DatePicker(this.datePickerLabel);

  @override
  _DatePickerState createState() => _DatePickerState(datePickerLabel);
}

class _DatePickerState extends State<DatePicker> {
  String datePickerLabel;
  DateTime selectedDate = DateTime.now();
  bool _hasBeenTapped = false;
  final dateFormat = DateFormat.yMMMMd("fr_FR");

  _DatePickerState(this.datePickerLabel);

  Future<Null> _selectDate(BuildContext context) async {
    _hasBeenTapped = true;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
//      locale: Locale('fr', 'FR'),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: _hasBeenTapped
          ? Text(
              dateFormat.format(selectedDate),
              style: TextStyle(color: Colors.blue, fontSize: 16),
            )
          : Text(
              datePickerLabel,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
    );
  }
}

class TimePicker extends StatefulWidget {
  final String timePickerLabel;

  TimePicker(this.timePickerLabel);

  @override
  _TimePickerState createState() => _TimePickerState(timePickerLabel);
}

class _TimePickerState extends State<TimePicker> {
  String timePickerLabel;
  bool _hasBeenTapped = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  final timeFormat = DateFormat.Hm();

  _TimePickerState(this.timePickerLabel);

  Future<Null> _selectTime(BuildContext context) async {
    _hasBeenTapped = true;
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: _hasBeenTapped
          ? Text(
              selectedTime.format(context),
              style: TextStyle(color: Colors.blue, fontSize: 16),
            )
          : Text(
              timePickerLabel,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
    );
  }
}

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "Créer un évènement",
            style: TextStyle(fontSize: 25),
//            textAlign: TextAlignV.center,
          ),
        ),
      ),
      body: Form(
//        key: null,
        child: Padding(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      isDense: false,
                      hintText: "Soirée...",
                      labelText: "Nom de l'évènement",
                      alignLabelWithHint: true,
                    ),
                    onSaved: (String value) {
// This optional block of code can be used to run
// code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.contains('@')
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
//                  decoration: BoxDecoration(
//                    border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.event, color: Colors.pink),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: DatePicker("Jour début"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: DatePicker("Jour fin"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.watch_later, color: Colors.pink),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TimePicker("Heure début"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TimePicker("Heure fin"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: textEditingController,
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
                  padding: EdgeInsets.only(top: 40, left: 16.0, right: 16.0),
                  child: TextFormField(
                    maxLength: 24,
                    maxLines: 1,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                    ),
                    label: Text("Ajouter une image",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                    color: Colors.pink,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
//class AddEvent extends StatelessWidget {
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: MediaQuery.of(context).size.width *0.5 ,
//      height: MediaQuery.of(context).size.height * 0.5 ,
//      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8.0),
//      child: Column(
//        children: <Widget>[
//          AlertDialog(
//            title: Text(
//              "Créer un évènement",
//              style: TextStyle(
//                color: Colors.blue,
//              ),
//            ),
//            content: Form(
//              child: Column(
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.all(16.0),
//                    child: TextFormField(
//                      textAlignVertical: TextAlignVertical.center,
//                      textAlign: TextAlign.left,
//                      style: TextStyle(color: Colors.pink),
//                      decoration: const InputDecoration(
//                        hintText: "Soirée...",
//                        labelText: "Nom de l'évènement",
//                      ),
//                      onSaved: (String value) {
//// This optional block of code can be used to run
//// code when the user saves the form.
//                      },
//                      validator: (String value) {
//                        return value.contains('@')
//                            ? 'Do not use the @ char.'
//                            : null;
//                      },
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(16.0),
//                    child: DatePicker(),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(16.0),
//                    child: TextFormField(
//                      style: TextStyle(color: Colors.pink),
//                      decoration: const InputDecoration(
//                        icon: Icon(
//                          Icons.location_on,
//                          color: Colors.pink,
//                        ),
//                        hintText: "Campus Artem...",
//                        labelText: "Localisation",
//                      ),
//                      onSaved: (String value) {},
//                      validator: (String value) {
//                        return value.contains('@')
//                            ? 'Do not use the @ char.'
//                            : null;
//                      },
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(16.0),
//                    child: TextFormField(
//                      maxLength: 240,
//                      maxLines: null,
//                      style: TextStyle(color: Colors.pink),
//                      decoration: const InputDecoration(
//                        isDense: false,
//                        icon: Icon(
//                          Icons.description,
//                          color: Colors.pink,
//                        ),
//                        labelText: "Description",
//                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                        border: OutlineInputBorder(),
//                      ),
//                      onSaved: (String value) {},
////                          validator: (String value) {},
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(16.0),
//                    child: RaisedButton.icon(
//                      icon: Icon(
//                        Icons.add_photo_alternate,
//                        color: Colors.white,
//                      ),
//                      label: Text("Ajouter une image",
//                          style: TextStyle(color: Colors.white)),
//                      onPressed: () {},
//                      color: Colors.pink,
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(top: 30.0),
//            child: RaisedButton(
//              child: Text(
//                "Créer",
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//              onPressed: () {},
//              color: Colors.blue,
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
