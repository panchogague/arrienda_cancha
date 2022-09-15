import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:court_finder/models/models.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryService = Provider.of<CategoryService>(context);
    final categories = categoryService.categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Title(),
        if (categoryService.isLoading)
          Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          ),
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
            text: TextSpan(
              text: 'Elige ',
              style: Theme.of(context).textTheme.headline3,
              children: <TextSpan>[
                TextSpan(
                    text: ' una categoría',
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
          ),
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

    return GestureDetector(
      onTap: () {
        final courtService = Provider.of<CourtService>(context, listen: false);
        Provider.of<CourtProvider>(context, listen: false).categoryIdSelected =
            category.id!;

        courtService.populateCourtsByCategory(category.id!);
        Navigator.pushNamed(context, 'search', arguments: category);
      },
      child: Container(
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
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor
                      ]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        blurRadius: 5,
                        offset: const Offset(4, 8) // changes position of shadow
                        )
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 10)),
                          Spacer(),
                          Icon(
                            FontAwesomeIcons.arrowRightLong,
                            color: Colors.white54,
                            size: 15,
                          )
                        ],
                      ),
                      _TotalCanchas(category.totalPlaces),
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
      ),
    );
  }
}

class _TotalCanchas extends StatelessWidget {
  const _TotalCanchas(
    this.totalPlaces, {
    Key? key,
  }) : super(key: key);

  final int totalPlaces;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool showTotal = size.height > 740.0;

    return showTotal
        ? Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              RotatedBox(
                quarterTurns: -1,
                child: Text('$totalPlaces CANCHAS',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          )
        : Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text('$totalPlaces CANCHAS',
                  style: Theme.of(context).textTheme.subtitle2),
            ],
          );
  }
}
