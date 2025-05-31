class TicketerModel {
  TicketerModel({
      this.status, 
      this.message, 
      this.data,});

  TicketerModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TicketerModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<TicketerModelData>? data;

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

class TicketerModelData {
  TicketerModelData({
      this.eventTicketId, 
      this.eventId, 
      this.ticketName, 
      this.noOfSeats, 
      this.ticketPrice, 
      this.maxTicketPrice, 
      this.saleStartDate, 
      this.saleStartTime, 
      this.saleEndDate, 
      this.saleEndTime, 
      this.saleEndCondition, 
      this.saleEndValue, 
      this.whenSaleEnd, 
      this.ticketDescription, 
      this.hideWhenNotSaleTag, 
      this.availableSeatDisplayTag, 
      this.noOfQtyBuyTag, 
      this.noOfQtyBuy, 
      this.qrSplitTag, 
      this.qrSplitQty, 
      this.ticketTransferTag, 
      this.createdUserId, 
      this.errorCode, 
      this.ticketStock,
      this.errorDesc,});

  TicketerModelData.fromJson(dynamic json) {
    eventTicketId = json['eventTicketId'];
    eventId = json['eventId'];
    ticketName = json['ticketName'];
    noOfSeats = json['noOfSeats'];
    ticketPrice = double.parse(json['ticketPrice'].toString());
    maxTicketPrice =double.parse(json['maxTicketPrice'].toString());
    saleStartDate = json['saleStartDate'];
    saleStartTime = json['saleStartTime'];
    saleEndDate = json['saleEndDate'];
    saleEndTime = json['saleEndTime'];
    saleEndCondition = json['saleEndCondition'];
    saleEndValue = json['saleEndValue'];
    whenSaleEnd = json['whenSaleEnd'];
    ticketDescription = json['ticketDescription'];
    hideWhenNotSaleTag = json['hideWhenNotSaleTag'];
    availableSeatDisplayTag = json['availableSeatDisplayTag'];
    noOfQtyBuyTag = json['noOfQtyBuyTag'];
    noOfQtyBuy = json['noOfQtyBuy'];
    qrSplitTag = json['qrSplitTag'];
    qrSplitQty = json['qrSplitQty'];
    ticketTransferTag = json['ticketTransferTag'];
    createdUserId = json['createdUserId'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
    ticketStock= json['ticketStock'];
    qty=0;
  }
  int? eventTicketId;
  int? eventId;
  String? ticketName;
  int? noOfSeats;
  double? ticketPrice;
  double? maxTicketPrice;
  String? saleStartDate;
  String? saleStartTime;
  String? saleEndDate;
  String? saleEndTime;
  String? saleEndCondition;
  int? saleEndValue;
  String? whenSaleEnd;
  String? ticketDescription;
  bool? hideWhenNotSaleTag;
  bool? availableSeatDisplayTag;
  bool? noOfQtyBuyTag;
  int? noOfQtyBuy;
  bool? qrSplitTag;
  int? qrSplitQty;
  bool? ticketTransferTag;
  int? createdUserId;
  int? ticketStock;
  int? errorCode;
  int? qty;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventTicketId'] = eventTicketId;
    map['eventId'] = eventId;
    map['ticketName'] = ticketName;
    map['noOfSeats'] = noOfSeats;
    map['ticketPrice'] = ticketPrice;
    map['maxTicketPrice'] = maxTicketPrice;
    map['saleStartDate'] = saleStartDate;
    map['saleStartTime'] = saleStartTime;
    map['saleEndDate'] = saleEndDate;
    map['saleEndTime'] = saleEndTime;
    map['saleEndCondition'] = saleEndCondition;
    map['saleEndValue'] = saleEndValue;
    map['whenSaleEnd'] = whenSaleEnd;
    map['ticketDescription'] = ticketDescription;
    map['hideWhenNotSaleTag'] = hideWhenNotSaleTag;
    map['availableSeatDisplayTag'] = availableSeatDisplayTag;
    map['noOfQtyBuyTag'] = noOfQtyBuyTag;
    map['noOfQtyBuy'] = noOfQtyBuy;
    map['qrSplitTag'] = qrSplitTag;
    map['qrSplitQty'] = qrSplitQty;
    map['ticketTransferTag'] = ticketTransferTag;
    map['createdUserId'] = createdUserId;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
     map['ticketStock'] = ticketStock;
    return map;
  }

}