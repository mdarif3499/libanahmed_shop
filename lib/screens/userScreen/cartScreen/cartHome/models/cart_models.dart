import 'dart:convert';

class CartAllProductModel {
    bool? success;
    String? message;
    Data? data;

    CartAllProductModel({
        this.success,
        this.message,
        this.data,
    });

    factory CartAllProductModel.fromRawJson(String str) => CartAllProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartAllProductModel.fromJson(Map<String, dynamic> json) => CartAllProductModel(
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
    Meta? meta;
    List<Result>? result;

    Data({
        this.meta,
        this.result,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Meta {
    int? page;
    int? limit;
    int? total;
    int? totalPage;

    Meta({
        this.page,
        this.limit,
        this.total,
        this.totalPage,
    });

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

class Result {
    String? id;
    ProductId? productId;
    String? sellerId;
    String? customerId;
    String? shopId;
    int? price;
    int? quantity;
    int? offer;
    int? weight;

    Result({
        this.id,
        this.productId,
        this.sellerId,
        this.customerId,
        this.shopId,
        this.price,
        this.quantity,
        this.offer,
        this.weight,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        productId: json["productId"] == null ? null : ProductId.fromJson(json["productId"]),
        sellerId: json["sellerId"],
        customerId: json["customerId"],
        shopId: json["shopId"],
        price: json["price"],
        quantity: json["quantity"],
        offer: json["offer"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId?.toJson(),
        "sellerId": sellerId,
        "customerId": customerId,
        "shopId": shopId,
        "price": price,
        "quantity": quantity,
        "offer": offer,
        "weight": weight,
    };
}

class ProductId {
    String? id;
    String? name;
    List<String>? images;

    ProductId({
        this.id,
        this.name,
        this.images,
    });

    factory ProductId.fromRawJson(String str) => ProductId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    };
}
