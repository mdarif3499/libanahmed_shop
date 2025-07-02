import 'dart:convert';

class OwnerAllCategoryModel {
    bool? success;
    String? message;
    Meta? meta;
    List<Datum>? data;

    OwnerAllCategoryModel({
        this.success,
        this.message,
        this.meta,
        this.data,
    });

    factory OwnerAllCategoryModel.fromRawJson(String str) => OwnerAllCategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OwnerAllCategoryModel.fromJson(Map<String, dynamic> json) => OwnerAllCategoryModel(
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
    String? name;
    String? image;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.name,
        this.image,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
