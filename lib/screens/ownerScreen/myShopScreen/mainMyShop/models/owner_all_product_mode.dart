import 'dart:convert';

class OwnerAllProductModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Datum>? data;

  OwnerAllProductModel({this.success, this.message, this.meta, this.data});

  factory OwnerAllProductModel.fromRawJson(String str) =>
      OwnerAllProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OwnerAllProductModel.fromJson(Map<String, dynamic> json) =>
      OwnerAllProductModel(
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
  String? sellerId;
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
  dynamic isOffer;

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
    sellerId: json["sellerId"],
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
    "sellerId": sellerId,
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
