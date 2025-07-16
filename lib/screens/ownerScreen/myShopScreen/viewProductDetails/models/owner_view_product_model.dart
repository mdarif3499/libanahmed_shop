class OwnerSingleProductModel {
  bool? success;
  String? message;
  Data? data;

  OwnerSingleProductModel({this.success, this.message, this.data});

  OwnerSingleProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
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
  String? weight;
  bool? isDeleted;
  Null isOffer;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isFavorite;

  Data(
      {this.sId,
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
      this.isOffer,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isFavorite});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['sellerId'];
    shopId = json['shopId'];
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
    isOffer = json['isOffer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
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
    data['isDeleted'] = isDeleted;
    data['isOffer'] = isOffer;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
