class TrackOrderModel {
  bool? success;
  String? message;
  Meta? meta;
  List<TrackOrderModelList>? data;

  TrackOrderModel({this.success, this.message, this.meta, this.data});

  TrackOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <TrackOrderModelList>[];
      json['data'].forEach((v) {
        data!.add(TrackOrderModelList.fromJson(v));
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

class TrackOrderModelList {
  String? sId;
  String? customerId;
  String? sellerId;
  String? shopId;
  List<ProductList>? productList;
  int? totalAmount;
  String? orderDate;
  String? status;
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
  String? createdAt;
  String? updatedAt;

  TrackOrderModelList(
      {this.sId,
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
      this.updatedAt});

  TrackOrderModelList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    zipCode = json['zip_code'];
    streetName = json['street_name'];
    stateCode = json['state_code'];
    locality = json['locality'];
    houseNumber = json['house_number'];
    country = json['country'];
    address = json['address'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(History.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
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
    data['zip_code'] = zipCode;
    data['street_name'] = streetName;
    data['state_code'] = stateCode;
    data['locality'] = locality;
    data['house_number'] = houseNumber;
    data['country'] = country;
    data['address'] = address;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
  String? sId;

  ProductList(
      {this.productId,
      this.sellerId,
      this.customerId,
      this.price,
      this.quantity,
      this.offer,
      this.weight,
      this.sId});

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
    sId = json['_id'];
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
    data['_id'] = sId;
    return data;
  }
}

class ProductId {
  Null isOffer;
  String? sId;
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
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? shopId;

  ProductId(
      {this.isOffer,
      this.sId,
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
      this.iV,
      this.shopId});

  ProductId.fromJson(Map<String, dynamic> json) {
    isOffer = json['isOffer'];
    sId = json['_id'];
    sellerId = json['sellerId'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    name = json['name'];
    details = json['details'];
    price = json['price'];
    stock = json['stock'];
    availableStock = json['availableStock'];
    images = json['images'].cast<String>();
    weight = json['weight'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isOffer'] = isOffer;
    data['_id'] = sId;
    data['sellerId'] = sellerId;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['name'] = name;
    data['details'] = details;
    data['price'] = price;
    data['stock'] = stock;
    data['availableStock'] = availableStock;
    data['images'] = images;
    data['weight'] = weight;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['shopId'] = shopId;
    return data;
  }
}

class History {
  String? status;
  String? date;
  String? sId;

  History({this.status, this.date, this.sId});

  History.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    date = json['date'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['date'] = date;
    data['_id'] = sId;
    return data;
  }
}
