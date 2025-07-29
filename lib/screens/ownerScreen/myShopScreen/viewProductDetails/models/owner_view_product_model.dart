import 'dart:convert';

class OwnerSingleProductModel {
  bool? success;
  String? message;
  Data? data;

  OwnerSingleProductModel({this.success, this.message, this.data});

  factory OwnerSingleProductModel.fromRawJson(String str) =>
      OwnerSingleProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OwnerSingleProductModel.fromJson(Map<String, dynamic> json) =>
      OwnerSingleProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
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
  dynamic isOffer;
  String? createdAt;
  String? updatedAt;
  int? version;
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
    this.version,
    this.isFavorite,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    weight: json["weight"]?.toDouble(),
    length: json["length"],
    height: json["height"],
    width: json["width"],
    isDeleted: json["isDeleted"],
    isOffer: json["isOffer"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    version: json["__v"],
    isFavorite: json["isFavorite"],
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": version,
    "isFavorite": isFavorite,
  };
}
