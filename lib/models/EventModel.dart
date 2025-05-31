class EventModel {
  EventModel({
    this.status,
    this.message,
    this.data,
  });

  EventModel.fromJson(dynamic json) {
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
    this.eventInfo,
    this.eventGallery,
    this.eventFAQs,
    this.eventSchedules,
  });

  Data.fromJson(dynamic json) {
    eventInfo = json['eventInfo'] != null
        ? EventInfo.fromJson(json['eventInfo'])
        : null;
    if (json['eventGallery'] != null) {
      eventGallery = [];
      json['eventGallery'].forEach((v) {
        eventGallery?.add(EventGallery.fromJson(v));
      });
    }
    if (json['eventFAQs'] != null) {
      eventFAQs = [];
      json['eventFAQs'].forEach((v) {
        eventFAQs?.add(EventFaQs.fromJson(v));
      });
    }
    if (json['eventSchedules'] != null) {
      eventSchedules = [];
      json['eventSchedules'].forEach((v) {
        eventSchedules?.add(EventSchedules.fromJson(v));
      });
    }
  }
  EventInfo? eventInfo;
  List<EventGallery>? eventGallery;
  List<EventFaQs>? eventFAQs;
  List<EventSchedules>? eventSchedules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (eventInfo != null) {
      map['eventInfo'] = eventInfo?.toJson();
    }
    if (eventGallery != null) {
      map['eventGallery'] = eventGallery?.map((v) => v.toJson()).toList();
    }
    if (eventFAQs != null) {
      map['eventFAQs'] = eventFAQs?.map((v) => v.toJson()).toList();
    }
    if (eventSchedules != null) {
      map['eventSchedules'] = eventSchedules?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class EventSchedules {
  EventSchedules({
    this.eventScheduleId,
    this.eventId,
    this.title,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.location,
    this.description,
    this.errorCode,
    this.errorDesc,
  });

  EventSchedules.fromJson(dynamic json) {
    eventScheduleId = json['eventScheduleId'];
    eventId = json['eventId'];
    title = json['title'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    location = json['location'];
    description = json['description'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventScheduleId;
  int? eventId;
  String? title;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? location;
  String? description;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventScheduleId'] = eventScheduleId;
    map['eventId'] = eventId;
    map['title'] = title;
    map['startDate'] = startDate;
    map['startTime'] = startTime;
    map['endDate'] = endDate;
    map['endTime'] = endTime;
    map['location'] = location;
    map['description'] = description;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }
}

class EventFaQs {
  EventFaQs({
    this.eventFAQId,
    this.eventId,
    this.question,
    this.answer,
    this.errorCode,
    this.errorDesc,
  });

  EventFaQs.fromJson(dynamic json) {
    eventFAQId = json['eventFAQId'];
    eventId = json['eventId'];
    question = json['question'];
    answer = json['answer'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventFAQId;
  int? eventId;
  String? question;
  String? answer;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventFAQId'] = eventFAQId;
    map['eventId'] = eventId;
    map['question'] = question;
    map['answer'] = answer;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }
}

class EventGallery {
  EventGallery({
    this.eventGalleryId,
    this.eventId,
    this.imageName,
    this.imagePath,
    this.videoLink,
    this.createdUserId,
    this.errorCode,
    this.errorDesc,
  });

  EventGallery.fromJson(dynamic json) {
    eventGalleryId = json['eventGalleryId'];
    eventId = json['eventId'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
    videoLink = json['videoLink'];
    createdUserId = json['createdUserId'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventGalleryId;
  int? eventId;
  String? imageName;
  String? imagePath;
  String? videoLink;
  int? createdUserId;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventGalleryId'] = eventGalleryId;
    map['eventId'] = eventId;
    map['imageName'] = imageName;
    map['imagePath'] = imagePath;
    map['videoLink'] = videoLink;
    map['createdUserId'] = createdUserId;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }
}

class EventInfo {
  EventInfo({
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
    this.errorCode,
    this.errorDesc,
    this.eventLikeTag,
    this.vendorfollowTag
  });

  EventInfo.fromJson(dynamic json) {
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
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
     vendorfollowTag = json['vendorfollowTag'];
    eventLikeTag = json['eventLikeTag'];
  }
  int? eventId;
  String? eventCode;
  String? vendorId;
  String? eventName;
  int? eventTypeId;
  String? eventType;
  int? eventCategoryId;
  String? eventCategory;
  String? eventSummary;
  String? detailedDescription;
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
  String? publishedTime;
  String? publishedUTCDatetime;
  String? termsConditions;
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
  int? errorCode;
  String? errorDesc;
  int? vendorfollowTag;
  int? eventLikeTag;

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
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }
}
