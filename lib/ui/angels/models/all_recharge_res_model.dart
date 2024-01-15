import 'dart:convert';

GetAllRechargeResModel getAllRechargeResModelFromJson(String str) =>
    GetAllRechargeResModel.fromJson(json.decode(str));

String getAllRechargeResModelToJson(GetAllRechargeResModel data) =>
    json.encode(data.toJson());

class GetAllRechargeResModel {
  int? status;
  bool? success;
  List<Datum>? data;

  GetAllRechargeResModel({
    this.status,
    this.success,
    this.data,
  });

  factory GetAllRechargeResModel.fromJson(Map<String, dynamic> json) =>
      GetAllRechargeResModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? amount;
  String? discountAmount;
  String? description;
  int? status;
  int? v;

  Datum({
    this.id,
    this.amount,
    this.discountAmount,
    this.description,
    this.status,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        amount: json["amount"],
        discountAmount: json["discount_amount"],
        description: json["description"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "discount_amount": discountAmount,
        "description": description,
        "status": status,
        "__v": v,
      };
}