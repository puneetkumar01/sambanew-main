class BookingTicketsModel {
  BookingTicketsModel({
      this.status, 
      this.message, 
      this.data,});

  BookingTicketsModel.fromJson(dynamic json) {
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
      this.eventName, 
      this.ticketName, 
      this.eventBannerImage1,
      this.eventBannerImagePath,
      this.newBookingNo, 
      this.newBookingNoQR, 
      this.venue, 
      this.venueAddress, 
      this.venueAddress1, 
      this.bookingDate, 
      this.startDate, 
      this.startTime, 
      this.bookingNo, 
      this.ticketTransferTag, 
      this.errorCode, 
      this.errorDesc,});

  Data.fromJson(dynamic json) {
    eventName = json['eventName'];
    ticketName = json['ticketName'];
     eventBannerImage1 = json['eventBannerImage1'];
    eventBannerImagePath = json['eventBannerImagePath'];
    newBookingNo = json['newBookingNo'];
    newBookingNoQR = json['newBookingNoQR'];
    venue = json['venue'];
    venueAddress = json['venueAddress'];
    venueAddress1 = json['venueAddress1'];
    bookingDate = json['bookingDate'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    bookingNo = json['bookingNo'];
    ticketTransferTag = json['ticketTransferTag'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  String? eventName;
  String? ticketName;
  String? newBookingNo;
  String? newBookingNoQR;
  String? venue;
    String? eventBannerImage1;
  String? eventBannerImagePath;
  String? venueAddress;
  String? venueAddress1;
  String? bookingDate;
  String? startDate;
  String? startTime;
  String? bookingNo;
  bool? ticketTransferTag;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventName'] = eventName;
    map['ticketName'] = ticketName;
    map['newBookingNo'] = newBookingNo;
    map['newBookingNoQR'] = newBookingNoQR;
    map['venue'] = venue;
    map['venueAddress'] = venueAddress;
    map['venueAddress1'] = venueAddress1;
    map['bookingDate'] = bookingDate;
    map['startDate'] = startDate;
    map['startTime'] = startTime;
    map['bookingNo'] = bookingNo;
    map['ticketTransferTag'] = ticketTransferTag;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}