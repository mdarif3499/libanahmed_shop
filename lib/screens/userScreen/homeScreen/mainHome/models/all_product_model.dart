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
        success: json["success"] as bool?,
        message: json["message"] as String?,
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
  double? weight;
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
    id: json["_id"] as String?,
    sellerId: json["sellerId"] == null
        ? null
        : SellerId.fromJson(json["sellerId"]),
    shopId: json["shopId"] as String?,
    categoryId: json["categoryId"] as String?,
    categoryName: json["categoryName"] as String?,
    name: json["name"] as String?,
    details: json["details"] as String?,
    price: json["price"] as int?,
    stock: json["stock"] as int?,
    availableStock: json["availableStock"] as int?,
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x as String)),
    weight: (json["weight"] as num?)?.toDouble(),
    length: json["length"] as int?,
    height: json["height"] as int?,
    width: json["width"] as int?,
    isDeleted: json["isDeleted"] as bool?,
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    isOffer: json["isOffer"] as int?,
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
    id: json["_id"] as String?,
    image: json["image"] as String?,
    fullName: json["fullName"] as String?,
    email: json["email"] as String?,
    role: json["role"] as String?,
    phone: json["phone"] as String?,
    isActive: json["isActive"] as bool?,
    isDeleted: json["isDeleted"] as bool?,
    postalCode: json["postal_code"] as String?,
    stateCode: json["state_code"] as String?,
    countryCode: json["country_code"] as String?,
    addressLine1: json["address_line1"] as String?,
    addressLine2: json["address_line2"] as String?,
    city: json["city"] as String?,
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"] as int?,
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
    page: json["page"] as int?,
    limit: json["limit"] as int?,
    total: json["total"] as int?,
    totalPage: json["totalPage"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}
