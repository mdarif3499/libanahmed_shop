import 'dart:convert';

class OwnerSingleCatProductModel {
    bool? success;
    String? message;
    Data? data;

    OwnerSingleCatProductModel({
        this.success,
        this.message,
        this.data,
    });

    factory OwnerSingleCatProductModel.fromRawJson(String str) => OwnerSingleCatProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OwnerSingleCatProductModel.fromJson(Map<String, dynamic> json) => OwnerSingleCatProductModel(
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
    String? name;
    String? image;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.id,
        this.name,
        this.image,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
