import 'package:animate_do/animate_do.dart';
import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:court_finder/modules/user/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CourtScreen extends StatelessWidget {
  const CourtScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourtModel court =
        ModalRoute.of(context)!.settings.arguments as CourtModel;

    final courtProvider = Provider.of<CourtProvider>(context);

    if (courtProvider.courtSelected != null &&
        courtProvider.courtSelected?.id != court.id) {
      cleanProviders(context);
    }
    courtProvider.courtSelected = court;

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
      ),
      bottomNavigationBar: const _Booking(),
    );
  }

  void cleanProviders(BuildContext context) {
    Provider.of<PickerSlotProvider>(context).cleanProperties();
    Provider.of<BookingProvider>(context).cleanProverties();
  }
}

class _Booking extends StatelessWidget {
  const _Booking({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    const style = TextStyle(color: Colors.white);
    return bookingProvider.showBooking
        ? SlideInUp(
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 110,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: Column(children: [
                    Container(
                      height: 45,
                      width: double.infinity,
                      color: const Color(0xff065781),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElasticIn(
                              controller: (p0) =>
                                  bookingProvider.dateAnimationController = p0,
                              child: Text(
                                bookingProvider.selectedDateFormat,
                                style: style,
                              ),
                            ),
                            ElasticIn(
                                controller: (p0) => bookingProvider
                                    .slotAnimationController = p0,
                                child: Text(bookingProvider.slotsFormat,
                                    style: style)),
                            ElasticIn(
                                controller: (p0) => bookingProvider
                                    .pitchAnimationController = p0,
                                child: Text(bookingProvider.pitch.name,
                                    style: style))
                          ]),
                    ),
                    Container(
                      height: 65,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {},
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'Book Now !',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              ElasticIn(
                                controller: (p0) => bookingProvider
                                    .priceAnimationController = p0,
                                child: Text(bookingProvider.pitch.priceFormated,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25)),
                              )
                            ]),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          )
        : const SizedBox();
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
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: SingleChildScrollView(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.horizontal_rule,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      court.name,
                      style: Theme.of(context).textTheme.headline1,
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
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const DatePickerHorizontal(),
                    const SizedBox(height: 20),
                    Text('Selecciona slot',
                        style: Theme.of(context).textTheme.headline5),
                    const _SlotPicker(),
                    const SizedBox(height: 20),
                    Text('Selecciona cancha',
                        style: Theme.of(context).textTheme.headline5),
                    const _PitchPicker()
                  ]),
            ),
            const SizedBox(height: 20),
            _Information()
          ],
        ),
      ),
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xffF0EEEF),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: const [
          Text('Como llegar'),
          Text('Descripción'),
          Text(
              'Aliquip adipisicing sint veniam aliqua minim mollit pariatur consequat. Cillum pariatur mollit cillum tempor minim sunt. Officia qui labore aliqua dolor aliquip enim laborum ea non anim. In magna dolor aliquip in ea ad in est sit. Voluptate do in ut incididunt nulla anim et qui et quis consectetur laboris velit laboris. Anim nulla magna dolor et qui. Minim do velit minim nostrud excepteur esse.'),
          Text('Facilidades')
        ]),
      ),
    );
  }
}

class _PitchPicker extends StatelessWidget {
  const _PitchPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SlotPitch(
            pitch: PitchModel(
                name: 'Cancha 1',
                price: 4500,
                size: '12 Jugadores',
                surface: 'Sintético'),
            index: 1,
          ),
          SlotPitch(
            pitch: PitchModel(
                name: 'Cancha 2',
                price: 12400,
                size: '12 Jugadores',
                surface: 'Sintético'),
            index: 2,
          ),
          SlotPitch(
              pitch: PitchModel(
                  name: 'Cancha Pasto',
                  price: 35000,
                  size: '22 Jugadores',
                  surface: 'Pasto'),
              index: 3),
          SlotPitch(
              pitch: PitchModel(
                  name: 'Cancha Pasto 2',
                  price: 35000,
                  size: '22 Jugadores',
                  surface: 'Pasto'),
              isAvailable: false,
              index: 4),
          SlotPitch(
              pitch: PitchModel(
                  name: 'Mini Cancha 2',
                  price: 6000,
                  size: '6 Jugadores',
                  surface: 'Cemento'),
              index: 5)
        ],
      ),
    );
  }
}

class _SlotPicker extends StatelessWidget {
  const _SlotPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtProvider = Provider.of<CourtProvider>(context);

    //TODO:validar cuando no hay slots
    //TODO: excluir las horas que ya pasaron

    return SizedBox(
      height: 85,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: courtProvider.slots.length,
        itemBuilder: (context, i) => SlotTime(
          index: i,
          slotHours: courtProvider.slots[i],
        ),
      ),
    );
  }
}
