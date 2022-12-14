import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:court_finder/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:provider/provider.dart';

class DatePickerHorizontal extends StatefulWidget {
  const DatePickerHorizontal({Key? key}) : super(key: key);

  @override
  State<DatePickerHorizontal> createState() => _DatePickerHorizontalState();
}

class _DatePickerHorizontalState extends State<DatePickerHorizontal> {
  final DatePickerController _datePickerController = DatePickerController();

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    DateTime now = bookingProvider.selectedDate;
    DateTime startDate = now;
    DateTime endDate = now.add(const Duration(days: 14));

    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: HorizontalDatePickerWidget(
        locale: 'es_ES',
        startDate: startDate,
        endDate: endDate,
        selectedDate: now,
        widgetWidth: MediaQuery.of(context).size.width,
        datePickerController: _datePickerController,
        selectedColor: myTheme.primaryColor,
        onValueSelected: (date) {
          final pickerProvider =
              Provider.of<PickerSlotProvider>(context, listen: false);
          pickerProvider.dateSelected = date;
          bookingProvider.selectedDate = date;
        },
      ),
    );
  }
}
