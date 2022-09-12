class OpenDayModel {
  int dayId;
  String from;
  String to;

  OpenDayModel(this.dayId, this.from, this.to);

  Map<String, dynamic> toMap() => {
        "dayId": dayId,
        "from": from,
        "to": to,
      };

  factory OpenDayModel.fromMap(Map<String, dynamic> json) =>
      OpenDayModel(json["dayId"], json["from"], json["to"]);

  String get dayName {
    switch (dayId) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }
}
