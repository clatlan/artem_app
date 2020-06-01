import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


class DateTimePicker extends StatefulWidget {
  final String pickerLabel;

  DateTimePicker(this.pickerLabel);

  @override
  _DateTimePickerState createState() => _DateTimePickerState(pickerLabel);
}

class _DateTimePickerState extends State<DateTimePicker> {
  final String pickerLabel;
  bool _hasBeenTapped = false;
  final dateFormat = DateFormat.yMMMMd("fr_FR").add_jm();

  DateTime selectedDate = DateTime.now();

  _DateTimePickerState(this.pickerLabel);

  void _selectDate(BuildContext context) {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onConfirm: (date) {
          setState(() {
            selectedDate = date;
            _hasBeenTapped = true;
          });
        }, currentTime: DateTime.now(), locale: LocaleType.fr);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 2.0,
      onPressed: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: _hasBeenTapped
            ? Text(
          dateFormat.format(selectedDate),
          style: TextStyle(color: Colors.blue),
          textAlign: TextAlign.center,
        )
            : Text(
          pickerLabel,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}