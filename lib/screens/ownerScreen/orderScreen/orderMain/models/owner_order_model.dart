import 'dart:convert';

import 'package:equatable/equatable.dart';

class OwnerOrderModel extends Equatable {
  const OwnerOrderModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory OwnerOrderModel.fromMap(Map<String, dynamic> map) {
    return OwnerOrderModel(
      success: map['success'] as bool?,
      message: map['message'] as String?,
      meta: map['meta'] != null
          ? Meta.fromMap(map['meta'] as Map<String, dynamic>)
          : null,
      data: map['data'] != null
          ? (map['data'] as List<dynamic>)
          .map((e) => DataItem.fromMap(e as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  factory OwnerOrderModel.fromJson(String source) => OwnerOrderModel.fromMap(
    json.decode(source) as Map<String, dynamic>,
  );

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<DataItem>? data;

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'meta': meta?.toMap(),
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  OwnerOrderModel copyWith({
    bool? success,
    String? message,
    Meta? meta,
    List<DataItem>? data,
  }) {
    return OwnerOrderModel(
      success: success ?? this.success,
      message: message ?? this.message,
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
    success,
    message,
    meta,
    data,
  ];
}

class Meta extends Equatable {
  const Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      page: map['page'] as int?,
      limit: map['limit'] as int?,
      total: map['total'] as int?,
      totalPage: map['totalPage'] as int?,
    );
  }

  factory Meta.fromJson(String source) => Meta.fromMap(
    json.decode(source) as Map<String, dynamic>,
  );

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };
  }

  String toJson() => json.encode(toMap());

  Meta copyWith({
    int? page,
    int? limit,
    int? total,
    int? totalPage,
  }) {
    return Meta(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [
    page,
    limit,
    total,
    totalPage,
  ];
}

class DataItem extends Equatable {
  const DataItem({
    this.Id,
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

  factory DataItem.fromMap(Map<String, dynamic> map) {
    return DataItem(
      Id: map['_id'] as String?,
      customerId: map['customerId'] as String?,
      sellerId: map['sellerId'] as String?,
      shopId: map['shopId'] as String?,
      productList: map['productList'] != null
          ? (map['productList'] as List<dynamic>)
          .map((e) => ProductListItem.fromMap(e as Map<String, dynamic>))
          .toList()
          : null,
      totalAmount: map['totalAmount'] as int?,
      orderDate: map['orderDate'] as String?,
      status: map['status'] as String?,
      paymentStatus: map['paymentStatus'] as String?,
      phoneNumber: map['phone_number'] as String?,
      zipCode: map['zip_code'] as String?,
      streetName: map['street_name'] as String?,
      stateCode: map['state_code'] as String?,
      locality: map['locality'] as String?,
      houseNumber: map['house_number'] as String?,
      country: map['country'] as String?,
      address: map['address'] as String?,
      history: map['history'] != null
          ? (map['history'] as List<dynamic>)
          .map((e) => HistoryItem.fromMap(e as Map<String, dynamic>))
          .toList()
          : null,
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  factory DataItem.fromJson(String source) => DataItem.fromMap(
    json.decode(source) as Map<String, dynamic>,
  );

  final String? Id;
  final String? customerId;
  final String? sellerId;
  final String? shopId;
  final List<ProductListItem>? productList;
  final int? totalAmount;
  final String? orderDate;
  final String? status;
  final String? paymentStatus;
  final String? phoneNumber;
  final String? zipCode;
  final String? streetName;
  final String? stateCode;
  final String? locality;
  final String? houseNumber;
  final String? country;
  final String? address;
  final List<HistoryItem>? history;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      '_id': Id,
      'customerId': customerId,
      'sellerId': sellerId,
      'shopId': shopId,
      'productList': productList?.map((x) => x.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'status': status,
      'paymentStatus': paymentStatus,
      'phone_number': phoneNumber,
      'zip_code': zipCode,
      'street_name': streetName,
      'state_code': stateCode,
      'locality': locality,
      'house_number': houseNumber,
      'country': country,
      'address': address,
      'history': history?.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  DataItem copyWith({
    String? Id,
    String? customerId,
    String? sellerId,
    String? shopId,
    List<ProductListItem>? productList,
    int? totalAmount,
    String? orderDate,
    String? status,
    String? paymentStatus,
    String? phoneNumber,
    String? zipCode,
    String? streetName,
    String? stateCode,
    String? locality,
    String? houseNumber,
    String? country,
    String? address,
    List<HistoryItem>? history,
    String? createdAt,
    String? updatedAt,
  }) {
    return DataItem(
      Id: Id ?? this.Id,
      customerId: customerId ?? this.customerId,
      sellerId: sellerId ?? this.sellerId,
      shopId: shopId ?? this.shopId,
      productList: productList ?? this.productList,
      totalAmount: totalAmount ?? this.totalAmount,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      zipCode: zipCode ?? this.zipCode,
      streetName: streetName ?? this.streetName,
      stateCode: stateCode ?? this.stateCode,
      locality: locality ?? this.locality,
      houseNumber: houseNumber ?? this.houseNumber,
      country: country ?? this.country,
      address: address ?? this.address,
      history: history ?? this.history,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    Id,
    customerId,
    sellerId,
    shopId,
    productList,
    totalAmount,
    orderDate,
    status,
    paymentStatus,
    phoneNumber,
    zipCode,
    streetName,
    stateCode,
    locality,
    houseNumber,
    country,
    address,
    history,
    createdAt,
    updatedAt,
  ];
}

class ProductListItem extends Equatable {
  const ProductListItem({
    this.productId,
    this.sellerId,
    this.customerId,
    this.price,
    this.quantity,
    this.offer,
    this.weight,
    this.Id,
  });

  factory ProductListItem.fromMap(Map<String, dynamic> map) {
    return ProductListItem(
      productId: map['productId'] != null
          ? ProductId.fromMap(map['productId'] as Map<String, dynamic>)
          : null,
      sellerId: map['sellerId'] as String?,
      customerId: map['customerId'] as String?,
      price: map['price'] as int?,
      quantity: map['quantity'] as int?,
      offer: map['offer'] as int?,
      weight: map['weight'] as int?,
      Id: map['_id'] as String?,
    );
  }

  factory ProductListItem.fromJson(String source) => ProductListItem.fromMap(
    json.decode(source) as Map<String, dynamic>,
  );

  final ProductId? productId;
  final String? sellerId;
  final String? customerId;
  final int? price;
  final int? quantity;
  final int? offer;
  final int? weight;
  final String? Id;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId?.toMap(),
      'sellerId': sellerId,
      'customerId': customerId,
      'price': price,
      'quantity': quantity,
      'offer': offer,
      'weight': weight,
      '_id': Id,
    };
  }

  String toJson() => json.encode(toMap());

  ProductListItem copyWith({
    ProductId? productId,
    String? sellerId,
    String? customerId,
    int? price,
    int? quantity,
    int? offer,
    int? weight,
    String? Id,
  }) {
    return ProductListItem(
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      customerId: customerId ?? this.customerId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      offer: offer ?? this.offer,
      weight: weight ?? this.weight,
      Id: Id ?? this.Id,
    );
  }

  @override
  List<Object?> get props => [
    productId,
    sellerId,
    customerId,
    price,
    quantity,
    offer,
    weight,
    Id,
  ];
}

class HistoryItem extends Equatable {
  const HistoryItem({
    this.status,
    this.date,
    this.Id,
  });

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      status: map['status'] as String?,
      date: map['date'] as String?,
      Id: map['_id'] as String?,
    );
  }

  factory HistoryItem.fromJson(String source) => HistoryItem.fromMap(
    json.decode(source) as Map<String, dynamic>,
  );

  final String? status;
  final String? date;
  final String? Id;

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'date': date,
      '_id': Id,
    };
  }

  String toJson() => json.encode(toMap());

  HistoryItem copyWith({
    String? status,
    String? date,
    String? Id,
  }) {
    return HistoryItem(
      status: status ?? this.status,
      date: date ?? this.date,
      Id: Id ?? this.Id,
    );
  }

  @override
  List<Object?> get props => [
    status,
    date,
    Id,
  ];
}

class ProductId extends Equatable {
  const ProductId({
    this.Id,
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
    this.V,
  });

  factory ProductId.fromMap(Map<String, dynamic> map) {
    return ProductId(
      Id: map['_id'] as String?,
      sellerId: map['sellerId'] as String?,
      shopId: map['shopId'] as String?,
      categoryId: map['categoryId'] as String?,
      categoryName: map['categoryName'] as String?,
      name: map['name'] as String?,
      details: map['details'] as String?,
      price: map['price'] as int?,
      stock: map['stock'] as int?,
      availableStock: map['availableStock'] as int?,
      images: map['images'] != null ? List<String>.from(map['images'] as List) : null,
      weight: map['weight'] as String?,
      isDeleted: map['isDeleted'] as bool?,
      createdAt: map['createdAt'] as String?,
      updatedAt: map['updatedAt'] as String?,
      V: map['__v'] as int?,
    );
  }

  factory ProductId.fromJson(String source) => ProductId.fromMap(
    json.decode(source) as Map<String, dynamic>,
  );

  final String? Id;
  final String? sellerId;
  final String? shopId;
  final String? categoryId;
  final String? categoryName;
  final String? name;
  final String? details;
  final int? price;
  final int? stock;
  final int? availableStock;
  final List<String>? images;
  final String? weight;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final int? V;

  Map<String, dynamic> toMap() {
    return {
      '_id': Id,
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
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': V,
    };
  }

  String toJson() => json.encode(toMap());

  ProductId copyWith({
    String? Id,
    String? sellerId,
    String? shopId,
    String? categoryId,
    String? categoryName,
    String? name,
    String? details,
    int? price,
    int? stock,
    int? availableStock,
    List<String>? images,
    String? weight,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
    int? V,
  }) {
    return ProductId(
      Id: Id ?? this.Id,
      sellerId: sellerId ?? this.sellerId,
      shopId: shopId ?? this.shopId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      name: name ?? this.name,
      details: details ?? this.details,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      availableStock: availableStock ?? this.availableStock,
      images: images ?? this.images,
      weight: weight ?? this.weight,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      V: V ?? this.V,
    );
  }

  @override
  List<Object?> get props => [
    Id,
    sellerId,
    shopId,
    categoryId,
    categoryName,
    name,
    details,
    price,
    stock,
    availableStock,
    images,
    weight,
    isDeleted,
    createdAt,
    updatedAt,
    V,
  ];
}

