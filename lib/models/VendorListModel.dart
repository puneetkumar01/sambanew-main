class VendorListModel {
  VendorListModel({
      this.status, 
      this.message, 
      this.data,});

  VendorListModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(VendorListModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<VendorListModelData>? data;

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

class VendorListModelData {
  VendorListModelData({
      this.vendorId, 
      this.vendorCode, 
      this.vendorName, 
      this.vendorcompany, 
      this.vendorShortDescr, 
      this.vendorLongDescr, 
      this.vendorLogoPath, 
      this.vendorLogoImage, 
      this.vendorBannerImage, 
      this.totalFollower, 
      this.vendorfollowtag, 
      this.errorCode, 
      this.errorDesc,});

  VendorListModelData.fromJson(dynamic json) {
    vendorId = json['vendorId'];
    vendorCode = json['vendorCode'];
    vendorName = json['vendorName'];
    vendorcompany = json['vendorcompany'];
    vendorShortDescr = json['vendorShortDescr'];
    vendorLongDescr = json['vendorLongDescr'];
    vendorLogoPath = json['vendorLogoPath'];
    vendorLogoImage = json['vendorLogoImage'];
    vendorBannerImage = json['vendorBannerImage'];
    totalFollower = json['totalFollower'];
    vendorfollowtag = json['vendorfollowtag'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? vendorId;
  String? vendorCode;
  String? vendorName;
  String? vendorcompany;
  String? vendorShortDescr;
  String? vendorLongDescr;
  String? vendorLogoPath;
  String? vendorLogoImage;
  String? vendorBannerImage;
  int? totalFollower;
  int? vendorfollowtag;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorId'] = vendorId;
    map['vendorCode'] = vendorCode;
    map['vendorName'] = vendorName;
    map['vendorcompany'] = vendorcompany;
    map['vendorShortDescr'] = vendorShortDescr;
    map['vendorLongDescr'] = vendorLongDescr;
    map['vendorLogoPath'] = vendorLogoPath;
    map['vendorLogoImage'] = vendorLogoImage;
    map['vendorBannerImage'] = vendorBannerImage;
    map['totalFollower'] = totalFollower;
    map['vendorfollowtag'] = vendorfollowtag;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}