class PromoCode {
  PromoCode({
      this.status, 
      this.message, 
      this.data,});

  PromoCode.fromJson(dynamic json) {
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
      this.eventPromoId, 
      this.eventId, 
      this.promoName, 
      this.promoCode, 
      this.errorCode, 
      this.errorDesc,});

  Data.fromJson(dynamic json) {
    eventPromoId = json['eventPromoId'];
    eventId = json['eventId'];
    promoName = json['promoName'];
    promoCode = json['promoCode'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventPromoId;
  int? eventId;
  String? promoName;
  String? promoCode;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventPromoId'] = eventPromoId;
    map['eventId'] = eventId;
    map['promoName'] = promoName;
    map['promoCode'] = promoCode;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}