import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final String pickerLabel;
  final void Function(DateTime date) getPickedDateTime;
  final DateTime initialDateTime;

  DateTimePicker({Key key, @required this.pickerLabel,
    @required this.getPickedDateTime, this.initialDateTime,});

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  bool _hasBeenTapped = false;
  final dateFormat = DateFormat.yMMMMd("fr_FR").add_jm();

  DateTime selectedDate;

  @override
  void initState() {
    selectedDate = widget.initialDateTime ?? DateTime.now();
    _hasBeenTapped = widget.initialDateTime != null ? true : false;
    super.initState();
  }


  void _selectDate(BuildContext context) {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
          setState(() {
            selectedDate = date;
            _hasBeenTapped = true;
            widget.getPickedDateTime(date);
          });
        }, currentTime: selectedDate, locale: LocaleType.fr);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 2.0,
      onPressed: () => _selectDate(context),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.4,
        child: _hasBeenTapped
            ? Text(
          dateFormat.format(selectedDate),
          style: TextStyle(color: Colors.blue),
          textAlign: TextAlign.center,
        )
            : Text(
          widget.pickerLabel,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}