import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends StatelessWidget{
  DateRangePickerController _datePickerController = DateRangePickerController();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfDateRangePicker(
        view: DateRangePickerView.month,
        monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
        selectionMode: DateRangePickerSelectionMode.multiRange,
        showActionButtons: true,
        controller: _datePickerController,
        onSubmit: (Object val) {
          print(val);
        },
        onCancel: () {
          _datePickerController.selectedRanges = null;
        },
      ),
    ));
  }

  
}