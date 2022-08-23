class SlotTimeModel {
  bool isAvailable;
  String to;
  String from; //TODO: quizas cambiar por tipo hora

  String get slotToString {
    return '$from - $to';
  }

  SlotTimeModel(
      {required this.to, required this.from, this.isAvailable = true});
}
