class Event {
  Event({
    this.eventVerified,
    this.eventTicketCost,
    this.eventCompanyName,
    this.eventUserMatch,
    this.eventDatetime,
    this.eventImages,
    this.eventAddress,
    this.eventName,
    this.eventCompanyImage,
  });

  bool? eventVerified;
  int? eventTicketCost;
  String? eventCompanyName;
  int? eventUserMatch;
  DateTime? eventDatetime;
  List<String>? eventImages;
  String? eventAddress;
  String? eventName;
  String? eventCompanyImage;

  factory Event.fromJson(Map<String, dynamic> json) {
    final timeString = json["event_datetime"].toString();

    String timeStamp = timeString.split("=")[1].split(",")[0].trim();

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));

    return Event(
      eventVerified: json["event_verified"],
      eventTicketCost: json["event_ticket_cost"],
      eventCompanyName: json["event_company_name"],
      eventUserMatch: json["event_user_match"],
      eventDatetime: dateTime,
      eventImages: List<String>.from(json["event_images"].map((x) => x)),
      eventAddress: json["event_address"],
      eventName: json["event_name"],
      eventCompanyImage: json["event_company_image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "event_verified": eventVerified,
        "event_ticket_cost": eventTicketCost,
        "event_company_name": eventCompanyName,
        "event_user_match": eventUserMatch,
        "event_datetime": eventDatetime,
        "event_images": List<dynamic>.from(eventImages!.map((x) => x)),
        "event_address": eventAddress,
        "event_name": eventName,
        "event_company_image": eventCompanyImage,
      };
}
