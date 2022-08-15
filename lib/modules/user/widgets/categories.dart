import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: size.height * 0.30,
          child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                _CategoryCard(),
                _CategoryCard(),
                _CategoryCard(),
                _CategoryCard()
              ]),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 5, bottom: 20),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
              text: 'Elige ',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: ' una categoría',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.normal)),
              ],
            ),
          ),
          const Spacer(),
          const Icon(
            FontAwesomeIcons.arrowRightLong,
            size: 18,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          const SizedBox(
            width: 150,
          ),
          Container(
            width: 140,
            height: size.height * 0.25,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xffFC864C), Color(0xffF24B59)]),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Futbol',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: const [
                        Text('DESCUBRE',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 10)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          FontAwesomeIcons.arrowRightLong,
                          color: Colors.white54,
                          size: 15,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const RotatedBox(
                      quarterTurns: -1,
                      child: Text('72 CANCHAS',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  ]),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      blurRadius: 5,
                      offset: const Offset(4, 8) // changes position of shadow
                      )
                ]),
                child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/pelota.png')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
