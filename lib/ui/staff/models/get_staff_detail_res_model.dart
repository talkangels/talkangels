// To parse this JSON data, do
//
//     final getStaffDetailResModel = getStaffDetailResModelFromJson(jsonString);

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
  List<Review>? reviews;
  DateTime? updatedAt;
  int? v;
  String? listingHours;
  String? fcmToken;
  int? countryCode;
  int? totalRating;
  String? dataAge;
  String? dataLanguage;

  Data({
    this.listing,
    this.earnings,
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
    this.status,
    this.charges,
    this.role,
    this.reviews,
    this.updatedAt,
    this.v,
    this.listingHours,
    this.fcmToken,
    this.countryCode,
    this.totalRating,
    this.dataAge,
    this.dataLanguage,
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
        gender: json["gender"],
        bio: json["bio"],
        image: json["image"],
        language: json["Language"],
        age: json["Age"],
        activeStatus: json["active_status"],
        callStatus: json["call_status"],
        status: json["status"],
        charges: json["charges"],
        role: json["role"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        listingHours: json["Listing_hours"],
        fcmToken: json["fcmToken"],
        countryCode: json["country_code"],
        totalRating: json["total_rating"],
        dataAge: json["age"],
        dataLanguage: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "listing": listing?.toJson(),
        "earnings": earnings?.toJson(),
        "_id": id,
        "user_name": userName,
        "name": name,
        "mobile_number": mobileNumber,
        "gender": gender,
        "bio": bio,
        "image": image,
        "Language": language,
        "Age": age,
        "active_status": activeStatus,
        "call_status": callStatus,
        "status": status,
        "charges": charges,
        "role": role,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "Listing_hours": listingHours,
        "fcmToken": fcmToken,
        "country_code": countryCode,
        "total_rating": totalRating,
        "age": dataAge,
        "language": dataLanguage,
      };
}

class Earnings {
  int? currentEarnings;
  int? sentWithdrawRequest;
  int? totalMoneyWithdraws;
  int? totalPendingMoney;

  Earnings({
    this.currentEarnings,
    this.sentWithdrawRequest,
    this.totalMoneyWithdraws,
    this.totalPendingMoney,
  });

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        currentEarnings: json["current_earnings"],
        sentWithdrawRequest: json["sent_withdraw_request"],
        totalMoneyWithdraws: json["total_money_withdraws"],
        totalPendingMoney: json["total_pending_money"],
      );

  Map<String, dynamic> toJson() => {
        "current_earnings": currentEarnings,
        "sent_withdraw_request": sentWithdrawRequest,
        "total_money_withdraws": totalMoneyWithdraws,
        "total_pending_money": totalPendingMoney,
      };
}

class Listing {
  List<CallHistory>? callHistory;
  String? totalMinutes;

  Listing({
    this.callHistory,
    this.totalMinutes,
  });

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        callHistory: json["call_history"] == null
            ? []
            : List<CallHistory>.from(
                json["call_history"]!.map((x) => CallHistory.fromJson(x))),
        totalMinutes: json["total_minutes"],
      );

  Map<String, dynamic> toJson() => {
        "call_history": callHistory == null
            ? []
            : List<dynamic>.from(callHistory!.map((x) => x.toJson())),
        "total_minutes": totalMinutes,
      };
}

class CallHistory {
  String? user;
  List<History>? history;
  String? id;

  CallHistory({
    this.user,
    this.history,
    this.id,
  });

  factory CallHistory.fromJson(Map<String, dynamic> json) => CallHistory(
        user: json["user"],
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "history": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
        "_id": id,
      };
}

class History {
  DateTime? date;
  String? callType;
  String? minutes;
  String? id;

  History({
    this.date,
    this.callType,
    this.minutes,
    this.id,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        callType: json["call_type"],
        minutes: json["minutes"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "call_type": callType,
        "minutes": minutes,
        "_id": id,
      };
}

class Review {
  String? user;
  List<UserReview>? userReviews;
  String? id;

  Review({
    this.user,
    this.userReviews,
    this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        userReviews: json["user_reviews"] == null
            ? []
            : List<UserReview>.from(
                json["user_reviews"]!.map((x) => UserReview.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "user_reviews": userReviews == null
            ? []
            : List<dynamic>.from(userReviews!.map((x) => x.toJson())),
        "_id": id,
      };
}

class UserReview {
  int? rating;
  String? comment;
  DateTime? date;
  String? id;

  UserReview({
    this.rating,
    this.comment,
    this.date,
    this.id,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) => UserReview(
        rating: json["rating"],
        comment: json["comment"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date?.toIso8601String(),
        "_id": id,
      };
}
