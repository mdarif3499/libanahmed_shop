import 'dart:convert';

class OwnerOrderModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Datum>? data;

  OwnerOrderModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory OwnerOrderModel.fromRawJson(String str) => OwnerOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OwnerOrderModel.fromJson(Map<String, dynamic> json) => OwnerOrderModel(
    success: json["success"],
    message: json["message"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  CustomerId? customerId;
  SellerId? sellerId;
  ShopId? shopId;
  List<ProductList>? productList;
  int? totalAmount;
  DateTime? orderDate;
  Status? status;
  String? paymentStatus;
  String? phoneNumber;
  String? zipCode;
  String? streetName;
  String? stateCode;
  String? locality;
  String? houseNumber;
  String? country;
  String? address;
  List<History>? history;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.customerId,
    this.sellerId,
    this.shopId,
    this.productList,
    this.totalAmount,
    this.orderDate,
    this.status,
    this.paymentStatus,
    this.phoneNumber,
    this.zipCode,
    this.streetName,
    this.stateCode,
    this.locality,
    this.houseNumber,
    this.country,
    this.address,
    this.history,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    customerId: customerIdValues.map[json["customerId"]]!,
    sellerId: sellerIdValues.map[json["sellerId"]]!,
    shopId: shopIdValues.map[json["shopId"]]!,
    productList: json["productList"] == null ? [] : List<ProductList>.from(json["productList"]!.map((x) => ProductList.fromJson(x))),
    totalAmount: json["totalAmount"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    status: statusValues.map[json["status"]]!,
    paymentStatus: json["paymentStatus"],
    phoneNumber: json["phone_number"],
    zipCode: json["zip_code"],
    streetName: json["street_name"],
    stateCode: json["state_code"],
    locality: json["locality"],
    houseNumber: json["house_number"],
    country: json["country"],
    address: json["address"],
    history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerIdValues.reverse[customerId],
    "sellerId": sellerIdValues.reverse[sellerId],
    "shopId": shopIdValues.reverse[shopId],
    "productList": productList == null ? [] : List<dynamic>.from(productList!.map((x) => x.toJson())),
    "totalAmount": totalAmount,
    "orderDate": orderDate?.toIso8601String(),
    "status": statusValues.reverse[status],
    "paymentStatus": paymentStatus,
    "phone_number": phoneNumber,
    "zip_code": zipCode,
    "street_name": streetName,
    "state_code": stateCode,
    "locality": locality,
    "house_number": houseNumber,
    "country": country,
    "address": address,
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum CustomerId {
  THE_681089_E9926_BE6_FB00_EE59_FB,
  THE_68513_C5891_AA957_D3_EFF938_C
}

final customerIdValues = EnumValues({
  "681089e9926be6fb00ee59fb": CustomerId.THE_681089_E9926_BE6_FB00_EE59_FB,
  "68513c5891aa957d3eff938c": CustomerId.THE_68513_C5891_AA957_D3_EFF938_C
});

class History {
  Status? status;
  DateTime? date;
  String? id;

  History({
    this.status,
    this.date,
    this.id,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
    status: statusValues.map[json["status"]]!,
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "date": date?.toIso8601String(),
    "_id": id,
  };
}

enum Status {
  COMPLETED,
  DELIVERY,
  FINISHED,
  ONGOING,
  RECIVED
}

final statusValues = EnumValues({
  "completed": Status.COMPLETED,
  "delivery": Status.DELIVERY,
  "finished": Status.FINISHED,
  "ongoing": Status.ONGOING,
  "recived": Status.RECIVED
});

class ProductList {
  ProductId? productId;
  SellerId? sellerId;
  CustomerId? customerId;
  int? price;
  int? quantity;
  int? offer;
  int? weight;
  String? id;

  ProductList({
    this.productId,
    this.sellerId,
    this.customerId,
    this.price,
    this.quantity,
    this.offer,
    this.weight,
    this.id,
  });

  factory ProductList.fromRawJson(String str) => ProductList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    productId: json["productId"] == null ? null : ProductId.fromJson(json["productId"]),
    sellerId: sellerIdValues.map[json["sellerId"]]!,
    customerId: customerIdValues.map[json["customerId"]]!,
    price: json["price"],
    quantity: json["quantity"],
    offer: json["offer"],
    weight: json["weight"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId?.toJson(),
    "sellerId": sellerIdValues.reverse[sellerId],
    "customerId": customerIdValues.reverse[customerId],
    "price": price,
    "quantity": quantity,
    "offer": offer,
    "weight": weight,
    "_id": id,
  };
}

class ProductId {
  Id? id;
  SellerId? sellerId;
  ShopId? shopId;
  CategoryId? categoryId;
  CategoryName? categoryName;
  Name? name;
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
  dynamic isOffer;

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
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isOffer,
  });

  factory ProductId.fromRawJson(String str) => ProductId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: idValues.map[json["_id"]]!,
    sellerId: sellerIdValues.map[json["sellerId"]]!,
    shopId: shopIdValues.map[json["shopId"]]!,
    categoryId: categoryIdValues.map[json["categoryId"]]!,
    categoryName: categoryNameValues.map[json["categoryName"]]!,
    name: nameValues.map[json["name"]]!,
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
    isOffer: json["isOffer"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "sellerId": sellerIdValues.reverse[sellerId],
    "shopId": shopIdValues.reverse[shopId],
    "categoryId": categoryIdValues.reverse[categoryId],
    "categoryName": categoryNameValues.reverse[categoryName],
    "name": nameValues.reverse[name],
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
    "isOffer": isOffer,
  };
}

enum CategoryId {
  THE_681094507_FEE747_F6_B89717_E,
  THE_681094907_FEE747_F6_B897186
}

final categoryIdValues = EnumValues({
  "681094507fee747f6b89717e": CategoryId.THE_681094507_FEE747_F6_B89717_E,
  "681094907fee747f6b897186": CategoryId.THE_681094907_FEE747_F6_B897186
});

enum CategoryName {
  BEVERAGE,
  FRUITS
}

final categoryNameValues = EnumValues({
  "Beverage": CategoryName.BEVERAGE,
  "Fruits": CategoryName.FRUITS
});

enum Id {
  THE_6816_D91_EA3_EEE21_F3267526_C,
  THE_6816_D97_FA3_EEE21_F32675271,
  THE_6822_C637829_A99_B96_E998_E58
}

final idValues = EnumValues({
  "6816d91ea3eee21f3267526c": Id.THE_6816_D91_EA3_EEE21_F3267526_C,
  "6816d97fa3eee21f32675271": Id.THE_6816_D97_FA3_EEE21_F32675271,
  "6822c637829a99b96e998e58": Id.THE_6822_C637829_A99_B96_E998_E58
});

enum Name {
  FRESH_STRAWBERRY,
  NATUREL_RED_APPLE,
  NATUREL_RED_APPLE222
}

final nameValues = EnumValues({
  "Fresh Strawberry": Name.FRESH_STRAWBERRY,
  "Naturel Red Apple": Name.NATUREL_RED_APPLE,
  "Naturel Red Apple222": Name.NATUREL_RED_APPLE222
});

enum SellerId {
  THE_68108_A6_D926_BE6_FB00_EE5_A10
}

final sellerIdValues = EnumValues({
  "68108a6d926be6fb00ee5a10": SellerId.THE_68108_A6_D926_BE6_FB00_EE5_A10
});

enum ShopId {
  THE_6822_B89_E84_B09_EB28_C10_DB0_A
}

final shopIdValues = EnumValues({
  "6822b89e84b09eb28c10db0a": ShopId.THE_6822_B89_E84_B09_EB28_C10_DB0_A
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
