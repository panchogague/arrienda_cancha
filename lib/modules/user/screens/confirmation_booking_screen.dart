import 'package:court_finder/modules/user/models/models.dart';
import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmationBookingScreen extends StatelessWidget {
  const ConfirmationBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingModel bookingModel =
        ModalRoute.of(context)!.settings.arguments as BookingModel;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff281853), //const Color(0xffF0EEEF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            height: size.height * 0.20,
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Confirma la reserva',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          _Content(bookingModel, size: size),
          SizedBox(
            height: size.height * 0.15,
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600))),
                  SizedBox(
                    width: size.width * 0.40,
                    height: 50,
                    child: OutlinedButton(
                        onPressed: () {
                          //TODO:grabar reserva
                          const snackBar = SnackBar(
                            content: Text('Reserva realizada con éxito'),
                          );

                          Navigator.pushReplacementNamed(context, 'home');
                          Provider.of<BookingProvider>(context, listen: false)
                              .cleanProverties();
                          Provider.of<PickerSlotProvider>(context,
                                  listen: false)
                              .cleanProperties();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor)),
                        child: const Text('Confirmar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                  )
                ]),
          )
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(
    this.booking, {
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    const styleSubtitle = TextStyle(
        color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: size.height * 0.65,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.court.name,
                      style: Theme.of(context).textTheme.headline2),
                  Text(booking.court.location, style: styleSubtitle),
                ],
              ),
            ]),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.selectedDateFormat,
                        style: Theme.of(context).textTheme.bodyText1),
                    const Text('Fecha', style: styleSubtitle)
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.slot.slotToString,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Text('Hora', style: styleSubtitle)
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.layers_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.pitch.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Text('Cancha', style: styleSubtitle)
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.verified_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '7A23FRTY12',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Text('Código', style: styleSubtitle)
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(children: [
              Icon(
                Icons.cancel_outlined,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                'Cancelación',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ]),
            const SizedBox(height: 10),
            Text(
              booking.court.cancellationPolicy,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: Theme.of(context).textTheme.headline4,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Total: ${booking.pitch.priceFormated}',
                style: Theme.of(context).textTheme.headline1,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
