import 'dart:convert';

class ViewOrderModel {
  bool? success;
  String? message;
  ViewOrderModelData? data;

  ViewOrderModel({this.success, this.message, this.data});

  factory ViewOrderModel.fromRawJson(String str) => ViewOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ViewOrderModel.fromJson(Map<String, dynamic> json) => ViewOrderModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? ViewOrderModelData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class ViewOrderModelData {
  String? id;
  String? customerId;
  String? sellerId;
  String? shopId;
  List<ProductList>? productList;
  int? totalAmount;
  String? orderDate;
  String? status;
  String? paymentStatus;
  String? phoneNumber;
  String? postalCode;
  String? stateCode;
  String? countryCode;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? createdAt;
  String? updatedAt;
  int? v;

  ViewOrderModelData({
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

  factory ViewOrderModelData.fromRawJson(String str) => ViewOrderModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ViewOrderModelData.fromJson(Map<String, dynamic> json) => ViewOrderModelData(
        id: json['_id'],
        customerId: json['customerId'],
        sellerId: json['sellerId'],
        shopId: json['shopId'],
        productList: json['productList'] != null
            ? List<ProductList>.from(json['productList'].map((x) => ProductList.fromJson(x)))
            : null,
        totalAmount: json['totalAmount'],
        orderDate: json['orderDate'],
        status: json['status'],
        paymentStatus: json['paymentStatus'],
        phoneNumber: json['phone_number'],
        postalCode: json['postal_code'],
        stateCode: json['state_code'],
        countryCode: json['country_code'],
        addressLine1: json['address_line1'],
        addressLine2: json['address_line2'],
        city: json['city'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'customerId': customerId,
        'sellerId': sellerId,
        'shopId': shopId,
        'productList': productList?.map((v) => v.toJson()).toList(),
        'totalAmount': totalAmount,
        'orderDate': orderDate,
        'status': status,
        'paymentStatus': paymentStatus,
        'phone_number': phoneNumber,
        'postal_code': postalCode,
        'state_code': stateCode,
        'country_code': countryCode,
        'address_line1': addressLine1,
        'address_line2': addressLine2,
        'city': city,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}

class ProductList {
  ProductId? productId;
  String? sellerId;
  String? customerId;
  int? price;
  int? quantity;
  int? offer;
  int? weight;
  int? height;
  int? width;
  int? length;
  String? id;

  ProductList({
    this.productId,
    this.sellerId,
    this.customerId,
    this.price,
    this.quantity,
    this.offer,
    this.weight,
    this.height,
    this.width,
    this.length,
    this.id,
  });

  factory ProductList.fromRawJson(String str) => ProductList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        productId: json['productId'] != null ? ProductId.fromJson(json['productId']) : null,
        sellerId: json['sellerId'],
        customerId: json['customerId'],
        price: json['price'],
        quantity: json['quantity'],
        offer: json['offer'],
        weight: json['weight'],
        height: json['height'],
        width: json['width'],
        length: json['length'],
        id: json['_id'],
      );

  Map<String, dynamic> toJson() => {
        'productId': productId?.toJson(),
        'sellerId': sellerId,
        'customerId': customerId,
        'price': price,
        'quantity': quantity,
        'offer': offer,
        'weight': weight,
        'height': height,
        'width': width,
        'length': length,
        '_id': id,
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
  int? weight;
  int? length;
  int? height;
  int? width;
  bool? isDeleted;
  dynamic isOffer;
  String? createdAt;
  String? updatedAt;
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

  factory ProductId.fromRawJson(String str) => ProductId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json['_id'],
        sellerId: json['sellerId'],
        shopId: json['shopId'],
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        name: json['name'],
        details: json['details'],
        price: json['price'],
        stock: json['stock'],
        availableStock: json['availableStock'],
        images: json['images'] != null ? List<String>.from(json['images']) : null,
        weight: json['weight'],
        length: json['length'],
        height: json['height'],
        width: json['width'],
        isDeleted: json['isDeleted'],
        isOffer: json['isOffer'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        v: json['__v'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'sellerId': sellerId,
        'shopId': shopId,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'name': name,
        'details': details,
        'price': price,
        'stock': stock,
        'availableStock': availableStock,
        'images': images,
        'weight': weight,
        'length': length,
        'height': height,
        'width': width,
        'isDeleted': isDeleted,
        'isOffer': isOffer,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}