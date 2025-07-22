class OwnerSingleProductModel {
  bool? success;
  String? message;
  Data? data;

  OwnerSingleProductModel({this.success, this.message, this.data});

  OwnerSingleProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

  Data.fromJson(Map<String, dynamic> json) {
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
    isFavorite = json['isFavorite'];
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
    data['isFavorite'] = isFavorite;
    return data;
  }
}