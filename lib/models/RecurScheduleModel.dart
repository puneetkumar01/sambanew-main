class RecurScheduleModel {
  RecurScheduleModel({
      this.status, 
      this.message, 
      this.data,});

  RecurScheduleModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RecurScheduleModelData.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<RecurScheduleModelData>? data;

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

class RecurScheduleModelData {
  RecurScheduleModelData({
      this.dateData, 
      this.timeData,});

  RecurScheduleModelData.fromJson(dynamic json) {
    dateData = json['dateData'] != null ? DateData.fromJson(json['dateData']) : null;
    if (json['timeData'] != null) {
      timeData = [];
      json['timeData'].forEach((v) {
        timeData?.add(TimeData.fromJson(v));
      });
    }
  }
  DateData? dateData;
  List<TimeData>? timeData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dateData != null) {
      map['dateData'] = dateData?.toJson();
    }
    if (timeData != null) {
      map['timeData'] = timeData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TimeData {
  TimeData({
      this.eventRecurScheduleId, 
      this.eventDayStartDate, 
      this.eventStartTime, 
      this.eventEndTime,});

  TimeData.fromJson(dynamic json) {
    eventRecurScheduleId = json['eventRecurScheduleId'];
    eventDayStartDate = json['eventDayStartDate'];
    eventStartTime = json['eventStartTime'];
    eventEndTime = json['eventEndTime'];
  }
  int? eventRecurScheduleId;
  String? eventDayStartDate;
  String? eventStartTime;
  String? eventEndTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventRecurScheduleId'] = eventRecurScheduleId;
    map['eventDayStartDate'] = eventDayStartDate;
    map['eventStartTime'] = eventStartTime;
    map['eventEndTime'] = eventEndTime;
    return map;
  }

}

class DateData {
  DateData({
      this.eventDayStartDate,});

  DateData.fromJson(dynamic json) {
    eventDayStartDate = json['eventDayStartDate'];
  }
  String? eventDayStartDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventDayStartDate'] = eventDayStartDate;
    return map;
  }

}