import 'dart:convert';

class OwnerProfileSettingsModel {
    bool? success;
    String? message;
    Data? data;

    OwnerProfileSettingsModel({
        this.success,
        this.message,
        this.data,
    });

    factory OwnerProfileSettingsModel.fromRawJson(String str) => OwnerProfileSettingsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OwnerProfileSettingsModel.fromJson(Map<String, dynamic> json) => OwnerProfileSettingsModel(
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
    String? id;
    String? privacyPolicy;
    String? aboutUs;
    String? support;
    String? termsOfService;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.id,
        this.privacyPolicy,
        this.aboutUs,
        this.support,
        this.termsOfService,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        privacyPolicy: json["privacyPolicy"],
        aboutUs: json["aboutUs"],
        support: json["support"],
        termsOfService: json["termsOfService"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "privacyPolicy": privacyPolicy,
        "aboutUs": aboutUs,
        "support": support,
        "termsOfService": termsOfService,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
