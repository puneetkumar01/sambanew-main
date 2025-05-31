class VendorDetails {
  VendorDetails({
      this.status, 
      this.message, 
      this.data,});

  VendorDetails.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(VendorDetailsData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<VendorDetailsData>? data;

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

class VendorDetailsData {
  VendorDetailsData({
      this.vendorInfo, 
      this.vendorSocialLinks,});

  VendorDetailsData.fromJson(dynamic json) {
    vendorInfo = json['vendorInfo'] != null ? VendorInfo.fromJson(json['vendorInfo']) : null;
    if (json['vendorSocialLinks'] != null) {
      vendorSocialLinks = [];
      json['vendorSocialLinks'].forEach((v) {
        vendorSocialLinks?.add(VendorSocialLinks.fromJson(v));
      });
    }
  }
  VendorInfo? vendorInfo;
  List<VendorSocialLinks>? vendorSocialLinks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (vendorInfo != null) {
      map['vendorInfo'] = vendorInfo?.toJson();
    }
    if (vendorSocialLinks != null) {
      map['vendorSocialLinks'] = vendorSocialLinks?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class VendorSocialLinks {
  VendorSocialLinks({
      this.vendorSocialLinkId, 
      this.vendorCode, 
      this.social, 
      this.socialLink, 
      this.errorCode, 
      this.errorDesc,});

  VendorSocialLinks.fromJson(dynamic json) {
    vendorSocialLinkId = json['vendorSocialLinkId'];
    vendorCode = json['vendorCode'];
    social = json['social'];
    socialLink = json['socialLink'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? vendorSocialLinkId;
  String? vendorCode;
  String? social;
  String? socialLink;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorSocialLinkId'] = vendorSocialLinkId;
    map['vendorCode'] = vendorCode;
    map['social'] = social;
    map['socialLink'] = socialLink;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}

class VendorInfo {
  VendorInfo({
      this.vendorCode, 
      this.vendorName, 
      this.vendorcompany, 
      this.vendorShortDescr, 
      this.vendorLongDescr, 
      this.vendorLogoPath, 
      this.vendorLogoImage, 
      this.vendorBannerImage, 
      this.totalFollower, 
      this.errorCode, 
      this.errorDesc,});

  VendorInfo.fromJson(dynamic json) {
    vendorCode = json['vendorCode'];
    vendorName = json['vendorName'];
    vendorcompany = json['vendorcompany'];
    vendorShortDescr = json['vendorShortDescr'];
    vendorLongDescr = json['vendorLongDescr'];
    vendorLogoPath = json['vendorLogoPath'];
    vendorLogoImage = json['vendorLogoImage'];
    vendorBannerImage = json['vendorBannerImage'];
    totalFollower = json['totalFollower'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  String? vendorCode;
  String? vendorName;
  String? vendorcompany;
  String? vendorShortDescr;
  String? vendorLongDescr;
  String? vendorLogoPath;
  String? vendorLogoImage;
  String? vendorBannerImage;
  int? totalFollower;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendorCode'] = vendorCode;
    map['vendorName'] = vendorName;
    map['vendorcompany'] = vendorcompany;
    map['vendorShortDescr'] = vendorShortDescr;
    map['vendorLongDescr'] = vendorLongDescr;
    map['vendorLogoPath'] = vendorLogoPath;
    map['vendorLogoImage'] = vendorLogoImage;
    map['vendorBannerImage'] = vendorBannerImage;
    map['totalFollower'] = totalFollower;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}