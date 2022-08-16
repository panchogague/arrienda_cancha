import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:court_finder/modules/user/models/models.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categories = CategoryModel.getAllCategories();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Title(),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: size.height * 0.30,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (_, int i) => _CategoryCard(category: categories[i]),
          ),
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
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool showTotal = size.height > 700.0;
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
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [category.primaryColor, category.secondaryColor]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      blurRadius: 5,
                      offset: const Offset(4, 8) // changes position of shadow
                      )
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
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
                    if (showTotal)
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text('${category.totalPlaces} CANCHAS',
                            style: const TextStyle(
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
                height: size.height * 0.10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.grey.withOpacity(0.9),
                  //       blurRadius: 5,
                  //       offset: const Offset(4, 8) // changes position of shadow
                  //       )
                  //]
                ),
                child: Image(
                    fit: BoxFit.contain, image: AssetImage(category.imgUrl)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
