class EventCatModel {
  EventCatModel({
      this.status, 
      this.message, 
      this.eventCategories, 
      this.eventTypes,});

  EventCatModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['eventCategories'] != null) {
      eventCategories = [];
      json['eventCategories'].forEach((v) {
        eventCategories?.add(EventCategories.fromJson(v));
      });
    }
    if (json['eventTypes'] != null) {
      eventTypes = [];
      json['eventTypes'].forEach((v) {
        eventTypes?.add(EventTypes.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<EventCategories>? eventCategories;
  List<EventTypes>? eventTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (eventCategories != null) {
      map['eventCategories'] = eventCategories?.map((v) => v.toJson()).toList();
    }
    if (eventTypes != null) {
      map['eventTypes'] = eventTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class EventTypes {
  EventTypes({
      this.eventTypeId, 
      this.eventCategoryId, 
      this.eventType, 
      this.imageName, 
      this.imagePath, 
      this.errorCode, 
      this.errorDesc,});

  EventTypes.fromJson(dynamic json) {
    eventTypeId = json['eventTypeId'];
    eventCategoryId = json['eventCategoryId'];
    eventType = json['eventType'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventTypeId;
  int? eventCategoryId;
  String? eventType;
  String? imageName;
  String? imagePath;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventTypeId'] = eventTypeId;
    map['eventCategoryId'] = eventCategoryId;
    map['eventType'] = eventType;
    map['imageName'] = imageName;
    map['imagePath'] = imagePath;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}

class EventCategories {
  EventCategories({
      this.eventCategoryId, 
      this.eventCategory, 
      this.errorCode, 
      this.errorDesc,});

  EventCategories.fromJson(dynamic json) {
    eventCategoryId = json['eventCategoryId'];
    eventCategory = json['eventCategory'];
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }
  int? eventCategoryId;
  String? eventCategory;
  int? errorCode;
  String? errorDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventCategoryId'] = eventCategoryId;
    map['eventCategory'] = eventCategory;
    map['errorCode'] = errorCode;
    map['errorDesc'] = errorDesc;
    return map;
  }

}