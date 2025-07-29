import 'dart:convert';

class SingleProductDetailsModel {
  bool? success;
  String? message;
  Data? data;

  SingleProductDetailsModel({this.success, this.message, this.data});

  factory SingleProductDetailsModel.fromRawJson(String str) =>
      SingleProductDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      SingleProductDetailsModel(
        success: json["success"] as bool?,
        message: json["message"] as String?,
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
  bool? isFavorite;

  Data({
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
    this.isFavorite,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    isFavorite: json["isFavorite"] as bool?,
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
    "isFavorite": isFavorite,
  };
}
