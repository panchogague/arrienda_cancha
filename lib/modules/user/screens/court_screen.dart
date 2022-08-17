import 'package:flutter/material.dart';
import 'package:court_finder/modules/user/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';

class CourtScreen extends StatelessWidget {
  const CourtScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourtModel court =
        ModalRoute.of(context)!.settings.arguments as CourtModel;
    return Scaffold(
        body: Stack(
      children: [
        ImageAppBar(
          imgUrl: court.imgUrl,
          tag: court.id,
          rating: court.rating,
        ),
        _DraggableDetail(court)
      ],
    ));
  }
}

class _DraggableDetail extends StatelessWidget {
  const _DraggableDetail(
    this.court, {
    Key? key,
  }) : super(key: key);

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.66,
        maxChildSize: 0.80,
        minChildSize: 0.66,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: _Content(court),
            ),
          );
        });
  }
}

class _Content extends StatelessWidget {
  const _Content(
    this.court, {
    Key? key,
  }) : super(key: key);

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              child: Icon(
                Icons.horizontal_rule,
                size: 60,
                color: Colors.grey,
              ),
            ),
            Text(
              court.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blueGrey,
                  size: 14,
                ),
                Text(
                  court.location,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const DatePickerHorizontal(),
            const SizedBox(height: 20),
            const Text('Selecciona slot',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 85,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: const [
                  SlotTime(
                    slotHours: ['11:00', '12:00'],
                    index: 1,
                  ),
                  SlotTime(
                    slotHours: ['13:00', '14:00'],
                    index: 2,
                  ),
                  SlotTime(slotHours: ['15:00', '16:00'], index: 3),
                  SlotTime(
                      slotHours: ['17:00', '18:00'],
                      isAvailable: false,
                      index: 4),
                  SlotTime(slotHours: ['19:00', '20:00'], index: 5)
                ],
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
