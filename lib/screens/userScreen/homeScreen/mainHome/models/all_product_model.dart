import 'dart:convert';

class ProductAllModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Datum>? data;

  ProductAllModel({this.success, this.message, this.meta, this.data});

  factory ProductAllModel.fromRawJson(String str) =>
      ProductAllModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAllModel.fromJson(Map<String, dynamic> json) =>
      ProductAllModel(
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  SellerId? sellerId;
  String? shopId;
  String? categoryId;
  String? categoryName;
  String? name;
  String? details;
  int? price;
  int? stock;
  int? availableStock;
  List<String>? images;
  int? weight;
  int? length;
  int? height;
  int? width;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isOffer;

  Datum({
    this.id,
    this.sellerId,
    this.shopId,
    this.categoryId,
    this.categoryName,
    this.name,
    this.details,
    this.price,
    this.stock,
    this.availableStock,
    this.images,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.isOffer,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    sellerId: json["sellerId"] == null
        ? null
        : SellerId.fromJson(json["sellerId"]),
    shopId: json["shopId"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    name: json["name"],
    details: json["details"],
    price: json["price"],
    stock: json["stock"],
    availableStock: json["availableStock"],
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    weight: json["weight"],
    length: json["length"],
    height: json["height"],
    width: json["width"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    isOffer: json["isOffer"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sellerId": sellerId?.toJson(),
    "shopId": shopId,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "name": name,
    "details": details,
    "price": price,
    "stock": stock,
    "availableStock": availableStock,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "weight": weight,
    "length": length,
    "height": height,
    "width": width,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "isOffer": isOffer,
  };
}

class SellerId {
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
  int? v;

  SellerId({
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
    this.v,
  });

  factory SellerId.fromRawJson(String str) =>
      SellerId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerId.fromJson(Map<String, dynamic> json) => SellerId(
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
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "__v": v,
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}
