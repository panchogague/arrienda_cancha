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
}
