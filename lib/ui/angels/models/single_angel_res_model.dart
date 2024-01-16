import 'dart:convert';

GetSingleAngelResModel getSingleAngelResModelFromJson(String str) =>
    GetSingleAngelResModel.fromJson(json.decode(str));

String getSingleAngelResModelToJson(GetSingleAngelResModel data) =>
    json.encode(data.toJson());

class GetSingleAngelResModel {
  int? status;
  bool? success;
  Data? data;

  GetSingleAngelResModel({
    this.status,
    this.success,
    this.data,
  });

  factory GetSingleAngelResModel.fromJson(Map<String, dynamic> json) =>
      GetSingleAngelResModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? userName;
  String? name;
  int? mobileNumber;
  String? gender;
  String? bio;
  String? image;
  String? language;
  String? age;
  String? activeStatus;
  String? callStatus;
  int? charges;
  String? fcmToken;
  int? countryCode;
  double? totalRating;
  List<Review>? reviews;

  Data({
    this.id,
    this.userName,
    this.name,
    this.mobileNumber,
    this.gender,
    this.bio,
    this.image,
    this.language,
    this.age,
    this.activeStatus,
    this.callStatus,
    this.charges,
    this.fcmToken,
    this.countryCode,
    this.totalRating,
    this.reviews,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userName: json["user_name"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        gender: json["gender"],
        bio: json["bio"],
        image: json["image"],
        language: json["language"],
        age: json["age"],
        activeStatus: json["active_status"],
        callStatus: json["call_status"],
        charges: json["charges"],
        fcmToken: json["fcmToken"],
        countryCode: json["country_code"],
        totalRating: json["total_rating"]?.toDouble(),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_name": userName,
        "name": name,
        "mobile_number": mobileNumber,
        "gender": gender,
        "bio": bio,
        "image": image,
        "language": language,
        "age": age,
        "active_status": activeStatus,
        "call_status": callStatus,
        "charges": charges,
        "fcmToken": fcmToken,
        "country_code": countryCode,
        "total_rating": totalRating,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Review {
  DateTime? date;
  int? rating;
  String? comment;
  String? id;

  Review({
    this.date,
    this.rating,
    this.comment,
    this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        rating: json["rating"],
        comment: json["comment"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "rating": rating,
        "comment": comment,
        "_id": id,
      };
}
