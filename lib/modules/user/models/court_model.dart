import 'package:court_finder/modules/user/models/models.dart';
import 'package:intl/intl.dart';

class CourtModel {
  String id; //TODO:cambiar esto si migramos de firebase
  String name;
  String imgUrl;
  String location;
  double? rating;
  String price; //TODO:cambiar por valor numberico
  String description;
  String howToAccess;
  String cancellationPolicy;

  Map<String, List<SlotTimeModel>> slotTimePerDate;

  //TODO: Pending

  CourtModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.location,
      required this.price,
      required this.slotTimePerDate,
      required this.description,
      required this.howToAccess,
      required this.cancellationPolicy,
      this.rating});

  static List<CourtModel> getPopulars() {
    var formatter = DateFormat('yyyy-MM-dd');
    final mapDate = <String, List<SlotTimeModel>>{};

    mapDate[formatter.format(DateTime.now())] = [
      SlotTimeModel(from: '10:00', to: '11:00'),
      SlotTimeModel(from: '11:00', to: '12:00'),
      SlotTimeModel(from: '12:00', to: '13:00'),
      SlotTimeModel(from: '15:00', to: '16:00'),
      SlotTimeModel(from: '17:00', to: '18:00', isAvailable: false),
      SlotTimeModel(from: '18:00', to: '19:00')
    ];

    mapDate[formatter.format(DateTime.now().add(const Duration(days: 1)))] = [
      SlotTimeModel(from: '10:00', to: '11:00', isAvailable: false),
      SlotTimeModel(from: '17:00', to: '18:00', isAvailable: false),
      SlotTimeModel(from: '18:00', to: '19:00', isAvailable: false)
    ];

    mapDate[formatter.format(DateTime.now().add(const Duration(days: 2)))] = [
      SlotTimeModel(from: '11:00', to: '12:00'),
      SlotTimeModel(from: '12:00', to: '13:00', isAvailable: false),
      SlotTimeModel(from: '15:00', to: '16:00'),
      SlotTimeModel(from: '17:00', to: '18:00'),
      SlotTimeModel(from: '18:00', to: '19:00', isAvailable: false)
    ];

    return [
      CourtModel(
          id: '1',
          name: 'Estadio waton linares.',
          location: 'Calle aranda #34, Villa Alemana.',
          imgUrl:
              'https://image-service.onefootball.com/transform?w=280&h=210&dpr=2&image=https%3A%2F%2Fimages.performgroup.com%2Fdi%2Flibrary%2FGOAL%2F5b%2Fef%2Fjan-breydel-stadium_jwo0464yk8s517j36es569jht.png%3Ft%3D821261326',
          rating: 5.0,
          price: '8.000/hr',
          description:
              'Ad ullamco non veniam pariatur incididunt magna proident. Et laboris adipisicing aliqua ut excepteur magna mollit enim quis mollit adipisicing nisi voluptate. Est consectetur est velit ullamco ut minim dolor ex culpa. Id ad veniam fugiat Lorem elit anim minim sunt fugiat velit culpa voluptate. Do sunt esse sint aliquip irure elit est id voluptate cillum nostrud exercitation enim. Laborum amet reprehenderit sit aute ipsum aute occaecat ad ad pariatur.',
          cancellationPolicy:
              'Laborum adipisicing eiusmod Lorem incididunt sit enim qui magna ad laborum cupidatat Lorem dolore. Enim mollit consequat dolor aliquip cupidatat quis quis ipsum amet est. Aliqua reprehenderit exercitation est eiusmod esse. Culpa magna quis occaecat amet. Ea tempor dolore ex minim ea esse do qui sint aliqua id nulla. Nostrud ea et est irure exercitation esse excepteur. Aliquip dolore et est ut ut laboris aute duis est.',
          howToAccess:
              'Qui enim consectetur sit nostrud eu amet cupidatat proident et ipsum. Velit sunt nisi laboris commodo nulla officia ut irure. Sint labore aliquip voluptate cillum ullamco esse. Non ex sunt commodo exercitation consectetur aute enim ipsum qui culpa esse laboris minim. Cupidatat labore magna dolor magna.',
          slotTimePerDate: mapDate),
      CourtModel(
          id: '2',
          name: 'Los Mormones.',
          location: 'Calle Garga #2124, Villa Alemana.',
          imgUrl:
              'https://www.tripl3shot.com/wp-content/uploads/Cancha-baloncesto-Tripl3-Shot-Granollers-1.jpg',
          rating: 4.3,
          price: '15.000/hr',
          description:
              'Est laboris cupidatat sit consectetur fugiat deserunt. Deserunt Lorem eu pariatur cillum ut elit commodo nulla. Eu minim elit ut commodo in aliqua ea anim occaecat. Laboris reprehenderit nostrud sit proident irure excepteur eu incididunt aliqua. Esse reprehenderit laborum cupidatat sint consequat. Ad reprehenderit dolor fugiat anim sint sunt nostrud laboris enim. Qui sunt exercitation irure et et ut id esse elit aliquip sunt.',
          cancellationPolicy:
              'Laborum adipisicing eiusmod Lorem incididunt sit enim qui magna ad laborum cupidatat Lorem dolore. Enim mollit consequat dolor aliquip cupidatat quis quis ipsum amet est. Aliqua reprehenderit exercitation est eiusmod esse. Culpa magna quis occaecat amet. Ea tempor dolore ex minim ea esse do qui sint aliqua id nulla. Nostrud ea et est irure exercitation esse excepteur. Aliquip dolore et est ut ut laboris aute duis est.',
          howToAccess:
              'Qui enim consectetur sit nostrud eu amet cupidatat proident et ipsum. Velit sunt nisi laboris commodo nulla officia ut irure. Sint labore aliquip voluptate cillum ullamco esse. Non ex sunt commodo exercitation consectetur aute enim ipsum qui culpa esse laboris minim. Cupidatat labore magna dolor magna.',
          slotTimePerDate: mapDate),
      CourtModel(
          id: '3',
          name: 'Canchas Padel, Chino Rios.',
          location: 'Av Valparaíso #21, Villa Alemana.',
          imgUrl:
              'https://civideportes.com.co/wp-content/uploads/2020/11/cancha-de-pa%CC%81del-de-vidrio--980x650.jpg',
          rating: 4.8,
          price: '10.500/hr',
          description:
              'Consectetur est veniam consectetur laboris aliquip proident non. Deserunt tempor sunt officia sit non non minim duis est nulla sunt. Ut tempor ullamco magna sit deserunt exercitation reprehenderit reprehenderit non pariatur occaecat. Anim reprehenderit cupidatat velit incididunt exercitation Lorem in ad non proident officia incididunt. Dolore irure reprehenderit minim quis deserunt aliquip eu. Reprehenderit officia nulla id eu cillum id qui in voluptate mollit sit anim aliquip.',
          cancellationPolicy:
              'Laborum adipisicing eiusmod Lorem incididunt sit enim qui magna ad laborum cupidatat Lorem dolore. Enim mollit consequat dolor aliquip cupidatat quis quis ipsum amet est. Aliqua reprehenderit exercitation est eiusmod esse. Culpa magna quis occaecat amet. Ea tempor dolore ex minim ea esse do qui sint aliqua id nulla. Nostrud ea et est irure exercitation esse excepteur. Aliquip dolore et est ut ut laboris aute duis est.',
          howToAccess:
              'Qui enim consectetur sit nostrud eu amet cupidatat proident et ipsum. Velit sunt nisi laboris commodo nulla officia ut irure. Sint labore aliquip voluptate cillum ullamco esse. Non ex sunt commodo exercitation consectetur aute enim ipsum qui culpa esse laboris minim. Cupidatat labore magna dolor magna.',
          slotTimePerDate: mapDate)
    ];
  }
}
