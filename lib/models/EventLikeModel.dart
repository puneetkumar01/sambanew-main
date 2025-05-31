class EventLikeModel {
  EventLikeModel({
      this.status, 
      this.message, 
      this.data,});

  EventLikeModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(EventLikeModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<EventLikeModelData>? data;

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

class EventLikeModelData {
  EventLikeModelData({
      this.eventId, 
      this.eventCode, 
      this.vendorId, 
      this.eventName, 
      this.eventTypeId, 
      this.eventType, 
      this.eventCategoryId, 
      this.eventCategory, 
      this.eventSummary, 
      this.detailedDescription, 
      this.currencyId, 
      this.currency, 
      this.icon, 
      this.tags, 
      this.venueTypeId, 
      this.venue, 
      this.venueAddress, 
      this.venueAddress1, 
      this.isRecurringTag, 
      this.timeZoneId, 
      this.timeZoneName, 
      this.startDate, 
      this.startTime, 
      this.hideStartTimeTag, 
      this.endDate, 
      this.endTime, 
      this.hideEndTimeTag, 
      this.utcStartDatetime, 
      this.utcEndDatetime, 
      this.createdUserId, 
      this.isActive, 
      this.isPublishedNowTag, 
      this.eventBannerImage1, 
      this.eventBannerImagePath, 
      this.isPrivateEventTag, 
      this.publishedDate, 
      this.publishedTime, 
      this.publishedUTCDatetime, 
      this.termsConditions, 
      this.vendorCode, 
      this.vendorName, 
      this.vendorcompany, 
      this.vendorShortDescr, 
      this.vendorLongDescr, 
      this.vendorLogoPath, 
      this.vendorLogoImage, 
      this.vendorBannerImage, 
      this.eventStatus, 
      this.ticketPriceOnward, 
      this.eventPopularity, 
      this.totalFollower, 
      this.vendorfollowTag, 
      this.eventLikeTag, 
      this.errorCode, 
      this.errorDesc,});

  EventLikeModelData.fromJson(dynamic json) {
    eventId = json['eventId'];
    eventCode = json['eventCode'];
    vendorId = json['vendorId'];
    eventName = json['eventName'];
    eventTypeId = json['eventTypeId'];
    eventType = json['eventType'];
    eventCategoryId = json['eventCategoryId'];
    eventCategory = json['eventCategory'];
    eventSummary = json['eventSummary'];
    detailedDescription = json['detailedDescription'];
    currencyId = json['currencyId'];
    currency = json['currency'];
    icon = json['icon'];
    tags = json['tags'];
    venueTypeId = json['venueTypeId'];
    venue = json['venue'];
    venueAddress = json['venueAddress'];
    venueAddress1 = json['venueAddress1'];
    isRecurringTag = json['isRecurringTag'];
    timeZoneId = json['timeZoneId'];
    timeZoneName = json['timeZoneName'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    hideStartTimeTag = json['hideStartTimeTag'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    hideEndTimeTag = json['hideEndTimeTag'];
    utcStartDatetime = json['utcStartDatetime'];
    utcEndDatetime = json['utcEndDatetime'];
    createdUserId = json['createdUserId'];
    isActive = json['isActive'];
    isPublishedNowTag = json['isPublishedNowTag'];
    eventBannerImage1 = json['eventBannerImage1'];
    eventBannerImagePath = json['eventBannerImagePath'];
    isPrivateEventTag = json['isPrivateEventTag'];
    publishedDate = json['publishedDate'];
    publishedTime = json['publishedTime'];
    publishedUTCDatetime = json['publishedUTCDatetime'];
    termsConditions = json['termsConditions'];
    vendorCode = json['vendorCode'];
    vendorName = json['vendorName'];
    vendorcompany = json['vendorcompany'];
    vendorShortDescr = json['vendorShortDescr'];
    vendorLongDescr = json['vendorLongDescr'];
    vendorLogoPath = json['vendorLogoPath'];
    vendorLogoImage = json['vendorLogoImage'];
    vendorBannerImage = json['vendorBannerImage'];
    eventStatus = json['eventStatus'];
    ticketPriceOnward = double.parse(json['ticketPriceOnward'].toString());
    eventPopularity = json['eventPopularity'];
    totalFollower = json['totalFollower'];
    vendorfollowTag = json['vendorfollowTag'];
    eventLikeTag = json['eventLikeTag'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventId;
  String? eventCode;
  String? vendorId;
  String? eventName;
  int? eventTypeId;
  String? eventType;
  int? eventCategoryId;
  String? eventCategory;
  dynamic eventSummary;
  dynamic detailedDescription;
  int? currencyId;
  String? currency;
  String? icon;
  String? tags;
  int? venueTypeId;
  String? venue;
  String? venueAddress;
  String? venueAddress1;
  bool? isRecurringTag;
  int? timeZoneId;
  String? timeZoneName;
  String? startDate;
  String? startTime;
  bool? hideStartTimeTag;
  String? endDate;
  String? endTime;
  bool? hideEndTimeTag;
  String? utcStartDatetime;
  String? utcEndDatetime;
  int? createdUserId;
  bool? isActive;
  bool? isPublishedNowTag;
  String? eventBannerImage1;
  String? eventBannerImagePath;
  String? isPrivateEventTag;
  String? publishedDate;
  dynamic publishedTime;
  String? publishedUTCDatetime;
  dynamic termsConditions;
  String? vendorCode;
  String? vendorName;
  String? vendorcompany;
  String? vendorShortDescr;
  String? vendorLongDescr;
  String? vendorLogoPath;
  String? vendorLogoImage;
  String? vendorBannerImage;
  String? eventStatus;
  double? ticketPriceOnward;
  int? eventPopularity;
  int? totalFollower;
  int? vendorfollowTag;
  int? eventLikeTag;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventId'] = eventId;
    map['eventCode'] = eventCode;
    map['vendorId'] = vendorId;
    map['eventName'] = eventName;
    map['eventTypeId'] = eventTypeId;
    map['eventType'] = eventType;
    map['eventCategoryId'] = eventCategoryId;
    map['eventCategory'] = eventCategory;
    map['eventSummary'] = eventSummary;
    map['detailedDescription'] = detailedDescription;
    map['currencyId'] = currencyId;
    map['currency'] = currency;
    map['icon'] = icon;
    map['tags'] = tags;
    map['venueTypeId'] = venueTypeId;
    map['venue'] = venue;
    map['venueAddress'] = venueAddress;
    map['venueAddress1'] = venueAddress1;
    map['isRecurringTag'] = isRecurringTag;
    map['timeZoneId'] = timeZoneId;
    map['timeZoneName'] = timeZoneName;
    map['startDate'] = startDate;
    map['startTime'] = startTime;
    map['hideStartTimeTag'] = hideStartTimeTag;
    map['endDate'] = endDate;
    map['endTime'] = endTime;
    map['hideEndTimeTag'] = hideEndTimeTag;
    map['utcStartDatetime'] = utcStartDatetime;
    map['utcEndDatetime'] = utcEndDatetime;
    map['createdUserId'] = createdUserId;
    map['isActive'] = isActive;
    map['isPublishedNowTag'] = isPublishedNowTag;
    map['eventBannerImage1'] = eventBannerImage1;
    map['eventBannerImagePath'] = eventBannerImagePath;
    map['isPrivateEventTag'] = isPrivateEventTag;
    map['publishedDate'] = publishedDate;
    map['publishedTime'] = publishedTime;
    map['publishedUTCDatetime'] = publishedUTCDatetime;
    map['termsConditions'] = termsConditions;
    map['vendorCode'] = vendorCode;
    map['vendorName'] = vendorName;
    map['vendorcompany'] = vendorcompany;
    map['vendorShortDescr'] = vendorShortDescr;
    map['vendorLongDescr'] = vendorLongDescr;
    map['vendorLogoPath'] = vendorLogoPath;
    map['vendorLogoImage'] = vendorLogoImage;
    map['vendorBannerImage'] = vendorBannerImage;
    map['eventStatus'] = eventStatus;
    map['ticketPriceOnward'] = ticketPriceOnward;
    map['eventPopularity'] = eventPopularity;
    map['totalFollower'] = totalFollower;
    map['vendorfollowTag'] = vendorfollowTag;
    map['eventLikeTag'] = eventLikeTag;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}