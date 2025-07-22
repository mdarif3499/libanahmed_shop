import 'dart:convert';

class OwnerProfileModel {
  bool? success;
  String? message;
  Data? data;

  OwnerProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory OwnerProfileModel.fromRawJson(String str) => OwnerProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OwnerProfileModel.fromJson(Map<String, dynamic> json) => OwnerProfileModel(
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
  String? image;
  String? fullName;
  String? email;
  String? role;
  String? phone;
  bool? isActive;
  bool? isDeleted;
  String? postalCode;
  String? stateCode;
  String? countryCode;
  String? addressLine1;
  String? addressLine2;
  String? city;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

  Data({
    this.id,
    this.image,
    this.fullName,
    this.email,
    this.role,
    this.phone,
    this.isActive,
    this.isDeleted,
    this.postalCode,
    this.stateCode,
    this.countryCode,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        image: json["image"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        postalCode: json["postal_code"],
        stateCode: json["state_code"],
        countryCode: json["country_code"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        city: json["city"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        version: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "fullName": fullName,
        "email": email,
        "role": role,
        "phone": phone,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "postal_code": postalCode,
        "state_code": stateCode,
        "country_code": countryCode,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": version,
      };
}