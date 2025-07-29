import 'dart:convert';

class UserMenuFavouriteModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Datum>? data;

  UserMenuFavouriteModel({this.success, this.message, this.meta, this.data});

  factory UserMenuFavouriteModel.fromRawJson(String str) =>
      UserMenuFavouriteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserMenuFavouriteModel.fromJson(Map<String, dynamic> json) =>
      UserMenuFavouriteModel(
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
  String? userId;
  ProductId? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({this.id, this.userId, this.productId, this.createdAt, this.updatedAt});

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] as String?,
    userId: json["userId"] as String?,
    productId: json["productId"] == null
        ? null
        : ProductId.fromJson(json["productId"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "productId": productId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ProductId {
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
  double? weight;
  int? length;
  int? height;
  int? width;
  bool? isDeleted;
  int? isOffer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProductId({
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
    this.isOffer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProductId.fromRawJson(String str) =>
      ProductId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"] as String?,
    sellerId: json["sellerId"] as String?,
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
    isOffer: json["isOffer"] as int?,
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
    "isOffer": isOffer,
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
