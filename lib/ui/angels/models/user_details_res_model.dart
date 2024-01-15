import 'dart:convert';

UserDetailsResponseModel userDetailsResponseModelFromJson(String str) =>
    UserDetailsResponseModel.fromJson(json.decode(str));

String userDetailsResponseModelToJson(UserDetailsResponseModel data) =>
    json.encode(data.toJson());

class UserDetailsResponseModel {
  int? status;
  bool? success;
  Data? data;

  UserDetailsResponseModel({
    this.status,
    this.success,
    this.data,
  });

  factory UserDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponseModel(
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
      };
}

class TalkAngelWallet {
  int? totalBallance;
  List<dynamic>? transections;

  TalkAngelWallet({
    this.totalBallance,
    this.transections,
  });

  factory TalkAngelWallet.fromJson(Map<String, dynamic> json) =>
      TalkAngelWallet(
        totalBallance: json["total_ballance"],
        transections: json["transections"] == null
            ? []
            : List<dynamic>.from(json["transections"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total_ballance": totalBallance,
        "transections": transections == null
            ? []
            : List<dynamic>.from(transections!.map((x) => x)),
      };
}
