class SlotTimeModel {
  bool isAvailable;
  String to;
  String from; //TODO: quizas cambiar por tipo hora

  SlotTimeModel(
      {required this.to, required this.from, this.isAvailable = true});
}
