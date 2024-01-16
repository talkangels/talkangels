// import 'dart:convert';
//
// GetAngleListResModel getAngleListResModelFromJson(String str) =>
//     GetAngleListResModel.fromJson(json.decode(str));
//
// String getAngleListResModelToJson(GetAngleListResModel data) =>
//     json.encode(data.toJson());
//
// class GetAngleListResModel {
//   int? status;
//   bool? success;
//   List<Datum>? data;
//   Pagination? pagination;
//
//   GetAngleListResModel({
//     this.status,
//     this.success,
//     this.data,
//     this.pagination,
//   });
//
//   factory GetAngleListResModel.fromJson(Map<String, dynamic> json) =>
//       GetAngleListResModel(
//         status: json["status"],
//         success: json["success"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         pagination: json["pagination"] == null
//             ? null
//             : Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "success": success,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "pagination": pagination?.toJson(),
//       };
// }
//
// class Datum {
//   String? id;
//   String? userName;
//   String? name;
//   int? mobileNumber;
//   String? gender;
//   String? bio;
//   String? image;
//   String? language;
//   String? age;
//   String? activeStatus;
//   String? callStatus;
//   int? charges;
//   String? fcmToken;
//   int? countryCode;
//   double? totalRating;
//
//   Datum({
//     this.id,
//     this.userName,
//     this.name,
//     this.mobileNumber,
//     this.gender,
//     this.bio,
//     this.image,
//     this.language,
//     this.age,
//     this.activeStatus,
//     this.callStatus,
//     this.charges,
//     this.fcmToken,
//     this.countryCode,
//     this.totalRating,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//         userName: json["user_name"],
//         name: json["name"],
//         mobileNumber: json["mobile_number"],
//         gender: json["gender"],
//         bio: json["bio"],
//         image: json["image"],
//         language: json["language"],
//         age: json["age"],
//         activeStatus: json["active_status"],
//         callStatus: json["call_status"],
//         charges: json["charges"],
//         fcmToken: json["fcmToken"],
//         countryCode: json["country_code"],
//         totalRating: json["total_rating"]?.toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "user_name": userName,
//         "name": name,
//         "mobile_number": mobileNumber,
//         "gender": gender,
//         "bio": bio,
//         "image": image,
//         "language": language,
//         "age": age,
//         "active_status": activeStatus,
//         "call_status": callStatus,
//         "charges": charges,
//         "fcmToken": fcmToken,
//         "country_code": countryCode,
//         "total_rating": totalRating,
//       };
// }
//
// class Pagination {
//   int? totalItems;
//   int? totalPages;
//   int? currentPageItem;
//   int? pageNo;
//   int? itemsPerPage;
//
//   Pagination({
//     this.totalItems,
//     this.totalPages,
//     this.currentPageItem,
//     this.pageNo,
//     this.itemsPerPage,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         totalItems: json["total_items"],
//         totalPages: json["total_pages"],
//         currentPageItem: json["current_page_item"],
//         pageNo: json["page_no"],
//         itemsPerPage: json["items_per_page"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total_items": totalItems,
//         "total_pages": totalPages,
//         "current_page_item": currentPageItem,
//         "page_no": pageNo,
//         "items_per_page": itemsPerPage,
//       };
// }

/// UPDETED
///
// To parse this JSON data, do
//
//     final getAngleListResModel = getAngleListResModelFromJson(jsonString);

import 'dart:convert';

GetAngleListResModel getAngleListResModelFromJson(String str) =>
    GetAngleListResModel.fromJson(json.decode(str));

String getAngleListResModelToJson(GetAngleListResModel data) =>
    json.encode(data.toJson());

class GetAngleListResModel {
  int? status;
  bool? success;
  List<Datum>? data;
  Pagination? pagination;

  GetAngleListResModel({
    this.status,
    this.success,
    this.data,
    this.pagination,
  });

  factory GetAngleListResModel.fromJson(Map<String, dynamic> json) =>
      GetAngleListResModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Datum {
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Pagination {
  int? totalItems;
  int? totalPages;
  int? currentPageItem;
  int? pageNo;
  int? itemsPerPage;

  Pagination({
    this.totalItems,
    this.totalPages,
    this.currentPageItem,
    this.pageNo,
    this.itemsPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json["total_items"],
        totalPages: json["total_pages"],
        currentPageItem: json["current_page_item"],
        pageNo: json["page_no"],
        itemsPerPage: json["items_per_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "total_pages": totalPages,
        "current_page_item": currentPageItem,
        "page_no": pageNo,
        "items_per_page": itemsPerPage,
      };
}
