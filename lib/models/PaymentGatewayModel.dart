class PaymentGatewayModel {
  PaymentGatewayModel({
      this.status, 
      this.message, 
      this.data,});

  PaymentGatewayModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PaymentGatewayModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<PaymentGatewayModelData>? data;

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

class PaymentGatewayModelData {
  PaymentGatewayModelData({
      this.paymentGatewayInfo, 
      this.paymodes,});

  PaymentGatewayModelData.fromJson(dynamic json) {
    paymentGatewayInfo = json['paymentGatewayInfo'] != null ? PaymentGatewayInfo.fromJson(json['paymentGatewayInfo']) : null;
    if (json['paymodes'] != null) {
      paymodes = [];
      json['paymodes'].forEach((v) {
        paymodes?.add(Paymodes.fromJson(v));
      });
    }
  }
  PaymentGatewayInfo? paymentGatewayInfo;
  List<Paymodes>? paymodes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentGatewayInfo != null) {
      map['paymentGatewayInfo'] = paymentGatewayInfo?.toJson();
    }
    if (paymodes != null) {
      map['paymodes'] = paymodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Paymodes {
  Paymodes({
      this.eventPGFeeId, 
      this.paymodeId, 
      this.paymentGatewayId, 
      this.paymode, 
      this.pgCode, 
      this.imagePath, 
      this.imageName, 
      this.errorCode, 
      this.errorDesc,});

  Paymodes.fromJson(dynamic json) {
    eventPGFeeId = json['eventPGFeeId'];
    paymodeId = json['paymodeId'];
    paymentGatewayId = json['paymentGatewayId'];
    paymode = json['paymode'];
    pgCode = json['pgCode'];
    imagePath = json['imagePath'];
    imageName = json['imageName'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventPGFeeId;
  int? paymodeId;
  int? paymentGatewayId;
  String? paymode;
  String? pgCode;
  String? imagePath;
  String? imageName;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventPGFeeId'] = eventPGFeeId;
    map['paymodeId'] = paymodeId;
    map['paymentGatewayId'] = paymentGatewayId;
    map['paymode'] = paymode;
    map['pgCode'] = pgCode;
    map['imagePath'] = imagePath;
    map['imageName'] = imageName;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}

class PaymentGatewayInfo {
  PaymentGatewayInfo({
      this.paymentGatewayId, 
      this.paymentGateway, 
      this.errorCode, 
      this.errorDesc,});

  PaymentGatewayInfo.fromJson(dynamic json) {
    paymentGatewayId = json['paymentGatewayId'];
    paymentGateway = json['paymentGateway'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? paymentGatewayId;
  String? paymentGateway;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['paymentGatewayId'] = paymentGatewayId;
    map['paymentGateway'] = paymentGateway;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}