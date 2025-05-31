class AddOnModel {
  AddOnModel({
      this.status, 
      this.message, 
      this.data,});

  AddOnModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.productId, 
      this.eventId, 
      this.productName, 
      this.productCategoryId, 
      this.productCategory, 
      this.description, 
      this.imageName, 
      this.imagePath, 
      this.totalQty, 
      this.price, 
      this.costPrice, 
      this.brand, 
      this.allowSaleTicketBoughtTag, 
      this.sellIndependentlyTag, 
      this.seperateQRCodeTag, 
      this.variantsTag, 
      this.shippingInfoTag, 
      this.qty,
      this.errorCode, 
      this.errorDesc,});

  Data.fromJson(dynamic json) {
    productId = json['productId'];
    eventId = json['eventId'];
    productName = json['productName'];
    productCategoryId = json['productCategoryId'];
    productCategory = json['productCategory'];
    description = json['description'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
    totalQty = json['totalQty'];
    price = json['price'];
    costPrice = json['costPrice'];
    qty=0;
    brand = json['brand'];
    allowSaleTicketBoughtTag = json['allowSaleTicketBoughtTag'];
    sellIndependentlyTag = json['sellIndependentlyTag'];
    seperateQRCodeTag = json['seperateQRCodeTag'];
    variantsTag = json['variantsTag'];
    shippingInfoTag = json['shippingInfoTag'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? productId;
  int? eventId;
  String? productName;
  int? productCategoryId;
  String? productCategory;
  String? description;
  String? imageName;
  String? imagePath;
  double? totalQty;
  double? price;
  int? qty;
  double? costPrice;
  String? brand;
  bool? allowSaleTicketBoughtTag;
  bool? sellIndependentlyTag;
  bool? seperateQRCodeTag;
  bool? variantsTag;
  bool? shippingInfoTag;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['eventId'] = eventId;
    map['productName'] = productName;
    map['productCategoryId'] = productCategoryId;
    map['productCategory'] = productCategory;
    map['description'] = description;
    map['imageName'] = imageName;
    map['imagePath'] = imagePath;
    map['totalQty'] = totalQty;
    map['price'] = price;
    map['costPrice'] = costPrice;
    map['brand'] = brand;
    map['allowSaleTicketBoughtTag'] = allowSaleTicketBoughtTag;
    map['sellIndependentlyTag'] = sellIndependentlyTag;
    map['seperateQRCodeTag'] = seperateQRCodeTag;
    map['variantsTag'] = variantsTag;
    map['shippingInfoTag'] = shippingInfoTag;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}