import 'dart:convert';

class OwnerOverviewCheckingModel {
    bool? success;
    String? message;
    Data? data;

    OwnerOverviewCheckingModel({
        this.success,
        this.message,
        this.data,
    });

    factory OwnerOverviewCheckingModel.fromRawJson(String str) => OwnerOverviewCheckingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OwnerOverviewCheckingModel.fromJson(Map<String, dynamic> json) => OwnerOverviewCheckingModel(
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
    bool? profileUpdate;
    bool? stripeConnectedAccount;
    bool? shopCreateVarify;

    Data({
        this.profileUpdate,
        this.stripeConnectedAccount,
        this.shopCreateVarify,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileUpdate: json["profileUpdate"],
        stripeConnectedAccount: json["stripeConnectedAccount"],
        shopCreateVarify: json["shopCreateVarify"],
    );

    Map<String, dynamic> toJson() => {
        "profileUpdate": profileUpdate,
        "stripeConnectedAccount": stripeConnectedAccount,
        "shopCreateVarify": shopCreateVarify,
    };
}
