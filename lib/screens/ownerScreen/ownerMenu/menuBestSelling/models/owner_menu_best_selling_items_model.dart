import 'dart:convert';

class OwnerBestSellingProductModel {
    bool? success;
    String? message;
    List<Datum>? data;

    OwnerBestSellingProductModel({
        this.success,
        this.message,
        this.data,
    });

    factory OwnerBestSellingProductModel.fromRawJson(String str) => OwnerBestSellingProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OwnerBestSellingProductModel.fromJson(Map<String, dynamic> json) => OwnerBestSellingProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    dynamic isOffer;
    String? id;
    String? sellerId;
    String? categoryId;
    String? categoryName;
    String? name;
    String? details;
    int? price;
    int? stock;
    int? availableStock;
    List<String>? images;
    String? weight;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? shopId;
    int? soldAmount;

    Datum({
        this.isOffer,
        this.id,
        this.sellerId,
        this.categoryId,
        this.categoryName,
        this.name,
        this.details,
        this.price,
        this.stock,
        this.availableStock,
        this.images,
        this.weight,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.shopId,
        this.soldAmount,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isOffer: json["isOffer"],
        id: json["_id"],
        sellerId: json["sellerId"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        name: json["name"],
        details: json["details"],
        price: json["price"],
        stock: json["stock"],
        availableStock: json["availableStock"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        weight: json["weight"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        shopId: json["shopId"],
        soldAmount: json["soldAmount"],
    );

    Map<String, dynamic> toJson() => {
        "isOffer": isOffer,
        "_id": id,
        "sellerId": sellerId,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "name": name,
        "details": details,
        "price": price,
        "stock": stock,
        "availableStock": availableStock,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "weight": weight,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "shopId": shopId,
        "soldAmount": soldAmount,
    };
}
