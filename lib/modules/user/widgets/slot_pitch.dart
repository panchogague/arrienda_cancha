import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/user/providers/providers.dart';

class SlotPitch extends StatelessWidget {
  const SlotPitch(
      {Key? key,
      required this.pitch,
      this.selectedColor = const Color(0xff2A9D8F),
      this.isAvailable = true,
      required this.index})
      : super(key: key);

  final PitchModel pitch;

  final Color selectedColor;
  final bool isAvailable;
  final int index;

  @override
  Widget build(BuildContext context) {
    final pickerProvider = Provider.of<PickerSlotProvider>(context);

    //TODO:refactorizar código

    bool isSelected = pickerProvider.selectedPitchIndex == index;

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

        pickerProvider.selectedPitchIndex = index;
        final bookingProvider =
            Provider.of<BookingProvider>(context, listen: false);
        bookingProvider.pitch = pitch;
      },
      child: Container(
        width: 145,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(8),
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            pitch.name,
            style: style,
          ),
          Text(pitch.size, style: TextStyle(color: textColor, fontSize: 12)),
          Text(
            pitch.priceFormated,
            style: style,
          )
        ]),
      ),
    );
  }
}
