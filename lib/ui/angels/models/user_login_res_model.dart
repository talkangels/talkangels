//
//
// import 'dart:convert';
//
// UserLoginResponseModel userLoginResponseModelFromJson(String str) =>
//     UserLoginResponseModel.fromJson(json.decode(str));
//
// String userLoginResponseModelToJson(UserLoginResponseModel data) =>
//     json.encode(data.toJson());
//
// class UserLoginResponseModel {
//   int? status;
//   bool? success;
//   String? message;
//   Data? data;
//   String? role;
//   String? token;
//
//   UserLoginResponseModel({
//     this.status,
//     this.success,
//     this.message,
//     this.data,
//     this.role,
//     this.token,
//   });
//
//   factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
//       UserLoginResponseModel(
//         status: json["status"],
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         role: json["role"],
//         token: json["Token"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "success": success,
//         "message": message,
//         "data": data?.toJson(),
//         "role": role,
//         "Token": token,
//       };
// }
//
// class Data {
//   TalkAngelWallet? talkAngelWallet;
//   String? id;
//   String? name;
//   int? mobileNumber;
//   int? countryCode;
//   String? referCode;
//   int? referCodeStatus;
//   String? image;
//   int? status;
//   String? role;
//   int? v;
//
//   Data({
//     this.talkAngelWallet,
//     this.id,
//     this.name,
//     this.mobileNumber,
//     this.countryCode,
//     this.referCode,
//     this.referCodeStatus,
//     this.image,
//     this.status,
//     this.role,
//     this.v,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         talkAngelWallet: json["talk_angel_wallet"] == null
//             ? null
//             : TalkAngelWallet.fromJson(json["talk_angel_wallet"]),
//         id: json["_id"],
//         name: json["name"],
//         mobileNumber: json["mobile_number"],
//         countryCode: json["country_code"],
//         referCode: json["refer_code"],
//         referCodeStatus: json["refer_code_status"],
//         image: json["image"],
//         status: json["status"],
//         role: json["role"],
//         v: json["__v"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "talk_angel_wallet": talkAngelWallet?.toJson(),
//         "_id": id,
//         "name": name,
//         "mobile_number": mobileNumber,
//         "country_code": countryCode,
//         "refer_code": referCode,
//         "refer_code_status": referCodeStatus,
//         "image": image,
//         "status": status,
//         "role": role,
//         "__v": v,
//       };
// }
//
// class TalkAngelWallet {
//   int? totalBallance;
//   List<Transection>? transections;
//
//   TalkAngelWallet({
//     this.totalBallance,
//     this.transections,
//   });
//
//   factory TalkAngelWallet.fromJson(Map<String, dynamic> json) =>
//       TalkAngelWallet(
//         totalBallance: json["total_ballance"],
//         transections: json["transections"] == null
//             ? []
//             : List<Transection>.from(
//                 json["transections"]!.map((x) => Transection.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total_ballance": totalBallance,
//         "transections": transections == null
//             ? []
//             : List<dynamic>.from(transections!.map((x) => x.toJson())),
//       };
// }
//
// class Transection {
//   int? amount;
//   String? type;
//   int? curentBellance;
//   DateTime? date;
//   String? id;
//
//   Transection({
//     this.amount,
//     this.type,
//     this.curentBellance,
//     this.date,
//     this.id,
//   });
//
//   factory Transection.fromJson(Map<String, dynamic> json) => Transection(
//         amount: json["amount"],
//         type: json["type"],
//         curentBellance: json["curent_bellance"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         id: json["_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//         "type": type,
//         "curent_bellance": curentBellance,
//         "date": date?.toIso8601String(),
//         "_id": id,
//       };
// }

///
///
// To parse this JSON data, do
//
//     final userLoginResponseModel = userLoginResponseModelFromJson(jsonString);

import 'dart:convert';

UserLoginResponseModel userLoginResponseModelFromJson(String str) =>
    UserLoginResponseModel.fromJson(json.decode(str));

String userLoginResponseModelToJson(UserLoginResponseModel data) =>
    json.encode(data.toJson());

class UserLoginResponseModel {
  int? status;
  bool? success;
  String? message;
  Data? data;
  String? userType;
  String? role;
  String? token;

  UserLoginResponseModel({
    this.status,
    this.success,
    this.message,
    this.data,
    this.userType,
    this.role,
    this.token,
  });

  factory UserLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        userType: json["user_type"],
        role: json["role"],
        token: json["Token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "user_type": userType,
        "role": role,
        "Token": token,
      };
}

class Data {
  TalkAngelWallet? talkAngelWallet;
  String? id;
  String? name;
  int? mobileNumber;
  String? image;
  int? status;
  String? role;
  int? v;
  String? fcmToken;
  int? countryCode;
  int? referCodeStatus;

  Data({
    this.talkAngelWallet,
    this.id,
    this.name,
    this.mobileNumber,
    this.image,
    this.status,
    this.role,
    this.v,
    this.fcmToken,
    this.countryCode,
    this.referCodeStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        talkAngelWallet: json["talk_angel_wallet"] == null
            ? null
            : TalkAngelWallet.fromJson(json["talk_angel_wallet"]),
        id: json["_id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        image: json["image"],
        status: json["status"],
        role: json["role"],
        v: json["__v"],
        fcmToken: json["fcmToken"],
        countryCode: json["country_code"],
        referCodeStatus: json["refer_code_status"],
      );

  Map<String, dynamic> toJson() => {
        "talk_angel_wallet": talkAngelWallet?.toJson(),
        "_id": id,
        "name": name,
        "mobile_number": mobileNumber,
        "image": image,
        "status": status,
        "role": role,
        "__v": v,
        "fcmToken": fcmToken,
        "country_code": countryCode,
        "refer_code_status": referCodeStatus,
      };
}

class TalkAngelWallet {
  int? totalBallance;
  List<Transection>? transections;

  TalkAngelWallet({
    this.totalBallance,
    this.transections,
  });

  factory TalkAngelWallet.fromJson(Map<String, dynamic> json) =>
      TalkAngelWallet(
        totalBallance: json["total_ballance"],
        transections: json["transections"] == null
            ? []
            : List<Transection>.from(
                json["transections"]!.map((x) => Transection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_ballance": totalBallance,
        "transections": transections == null
            ? []
            : List<dynamic>.from(transections!.map((x) => x.toJson())),
      };
}

class Transection {
  int? amount;
  String? paymentId;
  String? type;
  int? curentBellance;
  DateTime? date;
  String? id;

  Transection({
    this.amount,
    this.paymentId,
    this.type,
    this.curentBellance,
    this.date,
    this.id,
  });

  factory Transection.fromJson(Map<String, dynamic> json) => Transection(
        amount: json["amount"],
        paymentId: json["payment_id"],
        type: json["type"],
        curentBellance: json["curent_bellance"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "payment_id": paymentId,
        "type": type,
        "curent_bellance": curentBellance,
        "date": date?.toIso8601String(),
        "_id": id,
      };
}
