import 'dart:convert';

class SellerIncomeRatioModel {
  bool? success;
  String? message;
  List<Datum>? data;

  SellerIncomeRatioModel({this.success, this.message, this.data});

  factory SellerIncomeRatioModel.fromRawJson(String str) =>
      SellerIncomeRatioModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerIncomeRatioModel.fromJson(Map<String, dynamic> json) =>
      SellerIncomeRatioModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime? dateHour;
  double? totalIncome;

  Datum({this.dateHour, this.totalIncome});

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dateHour: json["dateHour"] == null
        ? null
        : DateTime.parse(json["dateHour"]),
    totalIncome: json["totalIncome"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "dateHour": dateHour != null
        ? "${dateHour!.year.toString().padLeft(4, '0')}-${dateHour!.month.toString().padLeft(2, '0')}-${dateHour!.day.toString().padLeft(2, '0')}"
        : null,
    "totalIncome": totalIncome,
  };
}
