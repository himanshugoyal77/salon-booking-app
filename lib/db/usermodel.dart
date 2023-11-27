class UserModel {
  final String phone;
  final String? age;
  final String? username;
  final String? email;
  final String? city;
  final String uid;
  final String? profileUrl;
  final String? createdAt;
  final List<String>? pastAppointments;
  final List<String>? upcomingAppointments;
  final List<String>? reviews;
  final List<String>? favourites;
  final List<String>? notifications;

  UserModel({
    required this.phone,
    this.age,
    this.username,
    this.email,
    this.city,
    required this.uid,
    this.profileUrl,
    this.createdAt,
    this.pastAppointments,
    this.upcomingAppointments,
    this.reviews,
    this.favourites,
    this.notifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phone: json["phone"],
        age: json["age"],
        username: json["username"],
        email: json["email"],
        city: json["city"],
        uid: json["uid"],
        profileUrl: json["profileUrl"],
        createdAt: json["createdAt"],
        pastAppointments: json["pastAppointments"] == null
            ? []
            : List<String>.from(json["pastAppointments"]!.map((x) => x)),
        upcomingAppointments: json["upcomingAppointments"] == null
            ? []
            : List<String>.from(json["upcomingAppointments"]!.map((x) => x)),
        reviews: json["reviews"] == null
            ? []
            : List<String>.from(json["reviews"]!.map((x) => x)),
        favourites: json["favourites"] == null
            ? []
            : List<String>.from(json["favourites"]!.map((x) => x)),
        notifications: json["notifications"] == null
            ? []
            : List<String>.from(json["notifications"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "age": age,
        "username": username,
        "email": email,
        "city": city,
        "uid": uid,
        "profileUrl": profileUrl,
        "createdAt": createdAt,
        "pastAppointments": pastAppointments == null
            ? []
            : List<dynamic>.from(pastAppointments!.map((x) => x)),
        "upcomingAppointments": upcomingAppointments == null
            ? []
            : List<dynamic>.from(upcomingAppointments!.map((x) => x)),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "favourites": favourites == null
            ? []
            : List<dynamic>.from(favourites!.map((x) => x)),
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x)),
      };
}
