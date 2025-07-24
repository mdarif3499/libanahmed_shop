import 'dart:convert';

class OwnerOrderTrackingModel {
    bool? success;
    String? message;
    Data? data;

    OwnerOrderTrackingModel({
        this.success,
        this.message,
        this.data,
    });

    factory OwnerOrderTrackingModel.fromRawJson(String str) => OwnerOrderTrackingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OwnerOrderTrackingModel.fromJson(Map<String, dynamic> json) => OwnerOrderTrackingModel(
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
    TrackResponse? trackResponse;

    Data({
        this.trackResponse,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackResponse: json["trackResponse"] == null ? null : TrackResponse.fromJson(json["trackResponse"]),
    );

    Map<String, dynamic> toJson() => {
        "trackResponse": trackResponse?.toJson(),
    };
}

class TrackResponse {
    List<Shipment>? shipment;

    TrackResponse({
        this.shipment,
    });

    factory TrackResponse.fromRawJson(String str) => TrackResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrackResponse.fromJson(Map<String, dynamic> json) => TrackResponse(
        shipment: json["shipment"] == null ? [] : List<Shipment>.from(json["shipment"]!.map((x) => Shipment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "shipment": shipment == null ? [] : List<dynamic>.from(shipment!.map((x) => x.toJson())),
    };
}

class Shipment {
    String? inquiryNumber;
    String? shipmentType;
    String? shipperNumber;
    String? pickupDate;
    List<Package>? package;
    List<String>? userRelation;

    Shipment({
        this.inquiryNumber,
        this.shipmentType,
        this.shipperNumber,
        this.pickupDate,
        this.package,
        this.userRelation,
    });

    factory Shipment.fromRawJson(String str) => Shipment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        inquiryNumber: json["inquiryNumber"],
        shipmentType: json["shipmentType"],
        shipperNumber: json["shipperNumber"],
        pickupDate: json["pickupDate"],
        package: json["package"] == null ? [] : List<Package>.from(json["package"]!.map((x) => Package.fromJson(x))),
        userRelation: json["userRelation"] == null ? [] : List<String>.from(json["userRelation"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "inquiryNumber": inquiryNumber,
        "shipmentType": shipmentType,
        "shipperNumber": shipperNumber,
        "pickupDate": pickupDate,
        "package": package == null ? [] : List<dynamic>.from(package!.map((x) => x.toJson())),
        "userRelation": userRelation == null ? [] : List<dynamic>.from(userRelation!.map((x) => x)),
    };
}

class Package {
    String? trackingNumber;
    List<DeliveryDate>? deliveryDate;
    DeliveryTime? deliveryTime;
    List<Activity>? activity;
    CurrentStatus? currentStatus;
    List<PackageAddress>? packageAddress;
    Weight? weight;
    Service? service;
    List<ReferenceNumber>? referenceNumber;
    DeliveryInformation? deliveryInformation;
    String? taxIndicator;
    Dimension? dimension;
    bool? isSmartPackage;
    int? packageCount;

    Package({
        this.trackingNumber,
        this.deliveryDate,
        this.deliveryTime,
        this.activity,
        this.currentStatus,
        this.packageAddress,
        this.weight,
        this.service,
        this.referenceNumber,
        this.deliveryInformation,
        this.taxIndicator,
        this.dimension,
        this.isSmartPackage,
        this.packageCount,
    });

    factory Package.fromRawJson(String str) => Package.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        trackingNumber: json["trackingNumber"],
        deliveryDate: json["deliveryDate"] == null ? [] : List<DeliveryDate>.from(json["deliveryDate"]!.map((x) => DeliveryDate.fromJson(x))),
        deliveryTime: json["deliveryTime"] == null ? null : DeliveryTime.fromJson(json["deliveryTime"]),
        activity: json["activity"] == null ? [] : List<Activity>.from(json["activity"]!.map((x) => Activity.fromJson(x))),
        currentStatus: json["currentStatus"] == null ? null : CurrentStatus.fromJson(json["currentStatus"]),
        packageAddress: json["packageAddress"] == null ? [] : List<PackageAddress>.from(json["packageAddress"]!.map((x) => PackageAddress.fromJson(x))),
        weight: json["weight"] == null ? null : Weight.fromJson(json["weight"]),
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
        referenceNumber: json["referenceNumber"] == null ? [] : List<ReferenceNumber>.from(json["referenceNumber"]!.map((x) => ReferenceNumber.fromJson(x))),
        deliveryInformation: json["deliveryInformation"] == null ? null : DeliveryInformation.fromJson(json["deliveryInformation"]),
        taxIndicator: json["taxIndicator"],
        dimension: json["dimension"] == null ? null : Dimension.fromJson(json["dimension"]),
        isSmartPackage: json["isSmartPackage"],
        packageCount: json["packageCount"],
    );

    Map<String, dynamic> toJson() => {
        "trackingNumber": trackingNumber,
        "deliveryDate": deliveryDate == null ? [] : List<dynamic>.from(deliveryDate!.map((x) => x.toJson())),
        "deliveryTime": deliveryTime?.toJson(),
        "activity": activity == null ? [] : List<dynamic>.from(activity!.map((x) => x.toJson())),
        "currentStatus": currentStatus?.toJson(),
        "packageAddress": packageAddress == null ? [] : List<dynamic>.from(packageAddress!.map((x) => x.toJson())),
        "weight": weight?.toJson(),
        "service": service?.toJson(),
        "referenceNumber": referenceNumber == null ? [] : List<dynamic>.from(referenceNumber!.map((x) => x.toJson())),
        "deliveryInformation": deliveryInformation?.toJson(),
        "taxIndicator": taxIndicator,
        "dimension": dimension?.toJson(),
        "isSmartPackage": isSmartPackage,
        "packageCount": packageCount,
    };
}

class Activity {
    Location? location;
    ReferenceNumber? status;
    String? date;
    String? time;
    String? gmtDate;
    String? gmtOffset;
    String? gmtTime;

    Activity({
        this.location,
        this.status,
        this.date,
        this.time,
        this.gmtDate,
        this.gmtOffset,
        this.gmtTime,
    });

    factory Activity.fromRawJson(String str) => Activity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        status: json["status"] == null ? null : ReferenceNumber.fromJson(json["status"]),
        date: json["date"],
        time: json["time"],
        gmtDate: json["gmtDate"],
        gmtOffset: json["gmtOffset"],
        gmtTime: json["gmtTime"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "status": status?.toJson(),
        "date": date,
        "time": time,
        "gmtDate": gmtDate,
        "gmtOffset": gmtOffset,
        "gmtTime": gmtTime,
    };
}

class Location {
    LocationAddress? address;

    Location({
        this.address,
    });

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"] == null ? null : LocationAddress.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
    };
}

class LocationAddress {
    String? countryCode;
    String? country;

    LocationAddress({
        this.countryCode,
        this.country,
    });

    factory LocationAddress.fromRawJson(String str) => LocationAddress.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationAddress.fromJson(Map<String, dynamic> json) => LocationAddress(
        countryCode: json["countryCode"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "country": country,
    };
}

class ReferenceNumber {
    String? type;
    String? description;
    String? code;
    String? statusCode;
    String? number;

    ReferenceNumber({
        this.type,
        this.description,
        this.code,
        this.statusCode,
        this.number,
    });

    factory ReferenceNumber.fromRawJson(String str) => ReferenceNumber.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReferenceNumber.fromJson(Map<String, dynamic> json) => ReferenceNumber(
        type: json["type"],
        description: json["description"],
        code: json["code"],
        statusCode: json["statusCode"],
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "description": description,
        "code": code,
        "statusCode": statusCode,
        "number": number,
    };
}

class CurrentStatus {
    String? description;
    String? code;

    CurrentStatus({
        this.description,
        this.code,
    });

    factory CurrentStatus.fromRawJson(String str) => CurrentStatus.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CurrentStatus.fromJson(Map<String, dynamic> json) => CurrentStatus(
        description: json["description"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "code": code,
    };
}

class DeliveryDate {
    String? type;
    String? date;

    DeliveryDate({
        this.type,
        this.date,
    });

    factory DeliveryDate.fromRawJson(String str) => DeliveryDate.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeliveryDate.fromJson(Map<String, dynamic> json) => DeliveryDate(
        type: json["type"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
    };
}

class DeliveryInformation {
    DeliveryPhoto? deliveryPhoto;

    DeliveryInformation({
        this.deliveryPhoto,
    });

    factory DeliveryInformation.fromRawJson(String str) => DeliveryInformation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeliveryInformation.fromJson(Map<String, dynamic> json) => DeliveryInformation(
        deliveryPhoto: json["deliveryPhoto"] == null ? null : DeliveryPhoto.fromJson(json["deliveryPhoto"]),
    );

    Map<String, dynamic> toJson() => {
        "deliveryPhoto": deliveryPhoto?.toJson(),
    };
}

class DeliveryPhoto {
    bool? isNonPostalCodeCountry;
    bool? isProximityMapViewable;

    DeliveryPhoto({
        this.isNonPostalCodeCountry,
        this.isProximityMapViewable,
    });

    factory DeliveryPhoto.fromRawJson(String str) => DeliveryPhoto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeliveryPhoto.fromJson(Map<String, dynamic> json) => DeliveryPhoto(
        isNonPostalCodeCountry: json["isNonPostalCodeCountry"],
        isProximityMapViewable: json["isProximityMapViewable"],
    );

    Map<String, dynamic> toJson() => {
        "isNonPostalCodeCountry": isNonPostalCodeCountry,
        "isProximityMapViewable": isProximityMapViewable,
    };
}

class DeliveryTime {
    String? startTime;
    String? type;
    String? endTime;

    DeliveryTime({
        this.startTime,
        this.type,
        this.endTime,
    });

    factory DeliveryTime.fromRawJson(String str) => DeliveryTime.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
        startTime: json["startTime"],
        type: json["type"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "startTime": startTime,
        "type": type,
        "endTime": endTime,
    };
}

class Dimension {
    String? height;
    String? length;
    String? width;
    String? unitOfDimension;

    Dimension({
        this.height,
        this.length,
        this.width,
        this.unitOfDimension,
    });

    factory Dimension.fromRawJson(String str) => Dimension.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dimension.fromJson(Map<String, dynamic> json) => Dimension(
        height: json["height"],
        length: json["length"],
        width: json["width"],
        unitOfDimension: json["unitOfDimension"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "length": length,
        "width": width,
        "unitOfDimension": unitOfDimension,
    };
}

class PackageAddress {
    String? type;
    String? name;
    String? attentionName;
    PackageAddressAddress? address;

    PackageAddress({
        this.type,
        this.name,
        this.attentionName,
        this.address,
    });

    factory PackageAddress.fromRawJson(String str) => PackageAddress.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PackageAddress.fromJson(Map<String, dynamic> json) => PackageAddress(
        type: json["type"],
        name: json["name"],
        attentionName: json["attentionName"],
        address: json["address"] == null ? null : PackageAddressAddress.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "attentionName": attentionName,
        "address": address?.toJson(),
    };
}

class PackageAddressAddress {
    String? addressLine1;
    String? addressLine2;
    String? city;
    String? stateProvince;
    String? postalCode;
    String? countryCode;
    String? country;

    PackageAddressAddress({
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.stateProvince,
        this.postalCode,
        this.countryCode,
        this.country,
    });

    factory PackageAddressAddress.fromRawJson(String str) => PackageAddressAddress.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PackageAddressAddress.fromJson(Map<String, dynamic> json) => PackageAddressAddress(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        stateProvince: json["stateProvince"],
        postalCode: json["postalCode"],
        countryCode: json["countryCode"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "stateProvince": stateProvince,
        "postalCode": postalCode,
        "countryCode": countryCode,
        "country": country,
    };
}

class Service {
    String? code;
    String? levelCode;
    String? description;

    Service({
        this.code,
        this.levelCode,
        this.description,
    });

    factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        code: json["code"],
        levelCode: json["levelCode"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "levelCode": levelCode,
        "description": description,
    };
}

class Weight {
    String? unitOfMeasurement;
    String? weight;

    Weight({
        this.unitOfMeasurement,
        this.weight,
    });

    factory Weight.fromRawJson(String str) => Weight.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        unitOfMeasurement: json["unitOfMeasurement"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "unitOfMeasurement": unitOfMeasurement,
        "weight": weight,
    };
}
