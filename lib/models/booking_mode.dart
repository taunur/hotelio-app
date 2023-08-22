class BookingModel {
  String id;
  String idHote;
  String cover;
  String name;
  String location;
  String date;
  int guest;
  String breakfast;
  String checkInTime;
  int night;
  int serviceFee;
  int activites;
  int totalPayment;
  String status;
  bool isDone;

  BookingModel({
    required this.id,
    required this.idHote,
    required this.cover,
    required this.name,
    required this.location,
    required this.date,
    required this.guest,
    required this.breakfast,
    required this.checkInTime,
    required this.night,
    required this.serviceFee,
    required this.activites,
    required this.totalPayment,
    required this.status,
    required this.isDone,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        idHote: json["id_hote"],
        cover: json["cover"],
        name: json["name"],
        location: json["location"],
        date: json["date"],
        guest: json["guest"],
        breakfast: json["breakfast"],
        checkInTime: json["check_in_time"],
        night: json["night"],
        serviceFee: json["service_fee"],
        activites: json["activites"],
        totalPayment: json["total_payment"],
        status: json["status"],
        isDone: json["is_done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_hote": idHote,
        "cover": cover,
        "name": name,
        "location": location,
        "date": date,
        "guest": guest,
        "breakfast": breakfast,
        "check_in_time": checkInTime,
        "night": night,
        "service_fee": serviceFee,
        "activites": activites,
        "total_payment": totalPayment,
        "status": status,
        "is_done": isDone,
      };
}
