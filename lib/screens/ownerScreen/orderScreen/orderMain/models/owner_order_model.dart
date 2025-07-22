class OwnerOrderModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Data>? data;

  OwnerOrderModel({this.success, this.message, this.meta, this.data});

  OwnerOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPage'] = totalPage;
    return data;
  }
}

class Data {
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
  String? trackingNumber;

  Data({
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
    this.trackingNumber,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    customerId = json['customerId'];
    sellerId = json['sellerId'];
    shopId = json['shopId'];
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    orderDate = json['orderDate'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    phoneNumber = json['phone_number'];
    postalCode = json['postal_code'];
    stateCode = json['state_code'];
    countryCode = json['country_code'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    trackingNumber = json['tacking_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['customerId'] = customerId;
    data['sellerId'] = sellerId;
    data['shopId'] = shopId;
    if (productList != null) {
      data['productList'] = productList!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['orderDate'] = orderDate;
    data['status'] = status;
    data['paymentStatus'] = paymentStatus;
    data['phone_number'] = phoneNumber;
    data['postal_code'] = postalCode;
    data['state_code'] = stateCode;
    data['country_code'] = countryCode;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['tacking_number'] = trackingNumber;
    return data;
  }
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

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] != null
        ? ProductId.fromJson(json['productId'])
        : null;
    sellerId = json['sellerId'];
    customerId = json['customerId'];
    price = json['price'];
    quantity = json['quantity'];
    offer = json['offer'];
    weight = json['weight'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productId != null) {
      data['productId'] = productId!.toJson();
    }
    data['sellerId'] = sellerId;
    data['customerId'] = customerId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['offer'] = offer;
    data['weight'] = weight;
    data['height'] = height;
    data['width'] = width;
    data['length'] = length;
    data['_id'] = id;
    return data;
  }
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
  int? version;

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
    this.version,
  });

  ProductId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sellerId = json['sellerId'];
    shopId = json['shopId'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    name = json['name'];
    details = json['details'];
    price = json['price'];
    stock = json['stock'];
    availableStock = json['availableStock'];
    images = json['images']?.cast<String>();
    weight = json['weight'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    isDeleted = json['isDeleted'];
    isOffer = json['isOffer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    version = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['sellerId'] = sellerId;
    data['shopId'] = shopId;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['name'] = name;
    data['details'] = details;
    data['price'] = price;
    data['stock'] = stock;
    data['availableStock'] = availableStock;
    data['images'] = images;
    data['weight'] = weight;
    data['length'] = length;
    data['height'] = height;
    data['width'] = width;
    data['isDeleted'] = isDeleted;
    data['isOffer'] = isOffer;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = version;
    return data;
  }
}