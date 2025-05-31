class BookingHistoryModel {
  BookingHistoryModel({
      this.status, 
      this.message, 
      this.data,});

  BookingHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BookingHistoryModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<BookingHistoryModelData>? data;

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

class BookingHistoryModelData {
  BookingHistoryModelData({
      this.eventId, 
      this.eventCode, 
      this.vendorId, 
      this.eventName, 
      this.eventBannerImage1, 
      this.eventBannerImagePath, 
      this.startDate, 
      this.startTime, 
      this.venue, 
      this.venueAddress, 
      this.utcStartDatetime, 
      this.utcEndDatetime, 
      this.eventStatus, 
      this.bookingId, 
      this.vrNo, 
      this.bookingNo, 
      this.customerId, 
      this.errorCode, 
      this.errorDesc,});

  BookingHistoryModelData.fromJson(dynamic json) {
    eventId = json['eventId'];
    eventCode = json['eventCode'];
    vendorId = json['vendorId'];
    eventName = json['eventName'];
    eventBannerImage1 = json['eventBannerImage1'];
    eventBannerImagePath = json['eventBannerImagePath'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    venue = json['venue'];
    venueAddress = json['venueAddress'];
    utcStartDatetime = json['utcStartDatetime'];
    utcEndDatetime = json['utcEndDatetime'];
    eventStatus = json['eventStatus'];
    bookingId = json['bookingId'];
    vrNo = json['vrNo'];
    bookingNo = json['bookingNo'];
    customerId = json['customerId'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventId;
  String? eventCode;
  int? vendorId;
  String? eventName;
  String? eventBannerImage1;
  String? eventBannerImagePath;
  String? startDate;
  String? startTime;
  String? venue;
  String? venueAddress;
  String? utcStartDatetime;
  String? utcEndDatetime;
  String? eventStatus;
  int? bookingId;
  int? vrNo;
  String? bookingNo;
  int? customerId;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventId'] = eventId;
    map['eventCode'] = eventCode;
    map['vendorId'] = vendorId;
    map['eventName'] = eventName;
    map['eventBannerImage1'] = eventBannerImage1;
    map['eventBannerImagePath'] = eventBannerImagePath;
    map['startDate'] = startDate;
    map['startTime'] = startTime;
    map['venue'] = venue;
    map['venueAddress'] = venueAddress;
    map['utcStartDatetime'] = utcStartDatetime;
    map['utcEndDatetime'] = utcEndDatetime;
    map['eventStatus'] = eventStatus;
    map['bookingId'] = bookingId;
    map['vrNo'] = vrNo;
    map['bookingNo'] = bookingNo;
    map['customerId'] = customerId;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}