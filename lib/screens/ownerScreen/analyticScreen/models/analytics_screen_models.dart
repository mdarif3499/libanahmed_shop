import 'dart:convert';

class SellerOverViewModel {
  bool? success;
  String? message;
  Data? data;

  SellerOverViewModel({this.success, this.message, this.data});

  factory SellerOverViewModel.fromRawJson(String str) =>
      SellerOverViewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerOverViewModel.fromJson(Map<String, dynamic> json) =>
      SellerOverViewModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? productCount;
  double? totalEarning;
  int? totalOrder;
  int? totalPendingOrder;

  Data({
    this.productCount,
    this.totalEarning,
    this.totalOrder,
    this.totalPendingOrder,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productCount: json["productCount"],
    totalEarning: json["totalEarning"]?.toDouble(),
    totalOrder: json["totalOrder"],
    totalPendingOrder: json["totalPendingOrder"],
  );

  Map<String, dynamic> toJson() => {
    "productCount": productCount,
    "totalEarning": totalEarning,
    "totalOrder": totalOrder,
    "totalPendingOrder": totalPendingOrder,
  };
}
