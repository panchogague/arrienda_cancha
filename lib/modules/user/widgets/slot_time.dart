import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlotTime extends StatelessWidget {
  const SlotTime(
      {Key? key,
      required this.slotHours,
      this.selectedColor = const Color(0xffF34F57),
      this.isAvailable = true,
      required this.index})
      : super(key: key);

  final List<String> slotHours;

  final Color selectedColor;
  final bool isAvailable;
  final int index;

  @override
  Widget build(BuildContext context) {
    final pickerProvider = Provider.of<PickerSlotProvider>(context);

    bool isSelected = pickerProvider.selectedIndex == index;

    Color textColor = isSelected ? Colors.white : Colors.black87;
    Color backgroundColor = Colors.white;

    if (isSelected) {
      backgroundColor = selectedColor;
    } else if (!isAvailable) {
      backgroundColor = Colors.grey.withOpacity(0.3);
      textColor = textColor.withOpacity(0.5);
    }

    final style = TextStyle(fontWeight: FontWeight.w800, color: textColor);

    return GestureDetector(
      onTap: () {
        if (!isAvailable) return;

        pickerProvider.selectedIndex = index;
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (isAvailable)
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(2, 4), // Shadow position
                ),
            ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: slotHours.map((e) => Text(e, style: style)).toList()),
      ),
    );
  }
}
