class CourtModel {
  String id; //TODO:cambiar esto si migramos de firebase
  String name;
  String imgUrl;
  String location;
  double? rating;
  String price; //TODO:cambiar por valor numberico

  //TODO: Pending

  CourtModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.location,
      required this.price,
      this.rating});

  static List<CourtModel> getPopulars() {
    return [
      CourtModel(
          id: DateTime.now().toString(),
          name: 'Estadio waton linares.',
          location: 'Calle aranda #34, Villa Alemana.',
          imgUrl:
              'https://image-service.onefootball.com/transform?w=280&h=210&dpr=2&image=https%3A%2F%2Fimages.performgroup.com%2Fdi%2Flibrary%2FGOAL%2F5b%2Fef%2Fjan-breydel-stadium_jwo0464yk8s517j36es569jht.png%3Ft%3D821261326',
          rating: 5.0,
          price: '8.000/hr'),
      CourtModel(
          id: DateTime.now().toString(),
          name: 'Los Mormones.',
          location: 'Calle Garga #2124, Villa Alemana.',
          imgUrl:
              'https://www.tripl3shot.com/wp-content/uploads/Cancha-baloncesto-Tripl3-Shot-Granollers-1.jpg',
          rating: 4.3,
          price: '15.000/hr'),
      CourtModel(
          id: DateTime.now().toString(),
          name: 'Canchas Padel, Chino Rios.',
          location: 'Av Valparaíso #21, Villa Alemana.',
          imgUrl:
              'https://civideportes.com.co/wp-content/uploads/2020/11/cancha-de-pa%CC%81del-de-vidrio--980x650.jpg',
          rating: 4.8,
          price: '10.500/hr')
    ];
  }
}
