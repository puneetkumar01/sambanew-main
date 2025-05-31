class CartModel {
  CartModel({
      this.status, 
      this.message, 
      this.data,});

  CartModel.fromJson(dynamic json) {
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
      this.tempCartId, 
      this.customerId, 
      this.eventId, 
      this.eventTicketId, 
      this.ticketName, 
      this.productId, 
      this.productName, 
      this.qty, 
      this.rate, 
      this.cost, 
      this.localSessionId, 
      this.conFee, 
      this.conFeeTaxDesc1, 
      this.conFeeTax1, 
      this.conFeeTaxDesc2, 
      this.conFeeTax2, 
      this.netTotal, 
      this.errorCode, 
      this.errorDesc,});

  Data.fromJson(dynamic json) {
    tempCartId = json['tempCartId'];
    customerId = json['customerId'];
    eventId = json['eventId'];
    eventTicketId = json['eventTicketId'];
    ticketName = json['ticketName'];
    productId = json['productId'];
    productName = json['productName'];
    qty = json['qty'];
    rate = json['rate'];
    cost = json['cost'];
    localSessionId = json['localSessionId'];
    conFee = json['conFee'];
    conFeeTaxDesc1 = json['conFeeTaxDesc1'];
    conFeeTax1 = json['conFeeTax1'];
    conFeeTaxDesc2 = json['conFeeTaxDesc2'];
    conFeeTax2 = json['conFeeTax2'];
    netTotal = json['netTotal'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? tempCartId;
  int? customerId;
  int? eventId;
  int? eventTicketId;
  String? ticketName;
  int? productId;
  String? productName;
  int? qty;
  double? rate;
  double? cost;
  String? localSessionId;
  double? conFee;
  dynamic conFeeTaxDesc1;
  double? conFeeTax1;
  dynamic conFeeTaxDesc2;
  double? conFeeTax2;
  double? netTotal;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tempCartId'] = tempCartId;
    map['customerId'] = customerId;
    map['eventId'] = eventId;
    map['eventTicketId'] = eventTicketId;
    map['ticketName'] = ticketName;
    map['productId'] = productId;
    map['productName'] = productName;
    map['qty'] = qty;
    map['rate'] = rate;
    map['cost'] = cost;
    map['localSessionId'] = localSessionId;
    map['conFee'] = conFee;
    map['conFeeTaxDesc1'] = conFeeTaxDesc1;
    map['conFeeTax1'] = conFeeTax1;
    map['conFeeTaxDesc2'] = conFeeTaxDesc2;
    map['conFeeTax2'] = conFeeTax2;
    map['netTotal'] = netTotal;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}