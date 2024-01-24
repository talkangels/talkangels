import 'dart:convert';

GetStaffDetailResModel getStaffDetailResModelFromJson(String str) =>
    GetStaffDetailResModel.fromJson(json.decode(str));

String getStaffDetailResModelToJson(GetStaffDetailResModel data) =>
    json.encode(data.toJson());

class GetStaffDetailResModel {
  int? status;
  bool? success;
  Data? data;

  GetStaffDetailResModel({
    this.status,
    this.success,
    this.data,
  });

  factory GetStaffDetailResModel.fromJson(Map<String, dynamic> json) =>
      GetStaffDetailResModel(
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
  Listing? listing;
  Earnings? earnings;
  String? id;
  String? userName;
  String? name;
  int? mobileNumber;
  int? countryCode;
  String? gender;
  String? bio;
  String? image;
  String? language;
  String? age;
  String? activeStatus;
  String? callStatus;
  int? status;
  int? charges;
  String? role;
  int? totalRating;
  List<dynamic>? reviews;
  DateTime? updatedAt;
  int? v;
  String? fcmToken;

  Data({
    this.listing,
    this.earnings,
    this.id,
    this.userName,
    this.name,
    this.mobileNumber,
    this.countryCode,
    this.gender,
    this.bio,
    this.image,
    this.language,
    this.age,
    this.activeStatus,
    this.callStatus,
    this.status,
    this.charges,
    this.role,
    this.totalRating,
    this.reviews,
    this.updatedAt,
    this.v,
    this.fcmToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        listing:
            json["listing"] == null ? null : Listing.fromJson(json["listing"]),
        earnings: json["earnings"] == null
            ? null
            : Earnings.fromJson(json["earnings"]),
        id: json["_id"],
        userName: json["user_name"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        countryCode: json["country_code"],
        gender: json["gender"],
        bio: json["bio"],
        image: json["image"],
        language: json["language"],
        age: json["age"],
        activeStatus: json["active_status"],
        callStatus: json["call_status"],
        status: json["status"],
        charges: json["charges"],
        role: json["role"],
        totalRating: json["total_rating"],
        reviews: json["reviews"] == null
            ? []
            : List<dynamic>.from(json["reviews"]!.map((x) => x)),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "listing": listing?.toJson(),
        "earnings": earnings?.toJson(),
        "_id": id,
        "user_name": userName,
        "name": name,
        "mobile_number": mobileNumber,
        "country_code": countryCode,
        "gender": gender,
        "bio": bio,
        "image": image,
        "language": language,
        "age": age,
        "active_status": activeStatus,
        "call_status": callStatus,
        "status": status,
        "charges": charges,
        "role": role,
        "total_rating": totalRating,
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "fcmToken": fcmToken,
      };
}

class Earnings {
  int? currentEarnings;
  int? totalMoneyWithdraws;
  int? totalPendingMoney;
  int? sentWithdrawRequest;

  Earnings({
    this.currentEarnings,
    this.totalMoneyWithdraws,
    this.totalPendingMoney,
    this.sentWithdrawRequest,
  });

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        currentEarnings: json["current_earnings"],
        totalMoneyWithdraws: json["total_money_withdraws"],
        totalPendingMoney: json["total_pending_money"],
        sentWithdrawRequest: json["sent_withdraw_request"],
      );

  Map<String, dynamic> toJson() => {
        "current_earnings": currentEarnings,
        "total_money_withdraws": totalMoneyWithdraws,
        "total_pending_money": totalPendingMoney,
        "sent_withdraw_request": sentWithdrawRequest,
      };
}

class Listing {
  String? totalMinutes;
  List<dynamic>? callHistory;

  Listing({
    this.totalMinutes,
    this.callHistory,
  });

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        totalMinutes: json["total_minutes"],
        callHistory: json["call_history"] == null
            ? []
            : List<dynamic>.from(json["call_history"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total_minutes": totalMinutes,
        "call_history": callHistory == null
            ? []
            : List<dynamic>.from(callHistory!.map((x) => x)),
      };
}
