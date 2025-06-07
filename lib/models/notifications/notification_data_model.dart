import 'package:kan_kardesi/utils/enums/notificaiton_enums.dart';

class NotificationDataModel {
  int? type;
  int? typeId;
  NotificationEnum? typeName;
  NotificationDataModel({this.type, this.typeId, this.typeName});

  NotificationEnum? setEnum() {
    switch (type) {
      case 1:
        return NotificationEnum.openBlogDetail;
      case 2:
        return NotificationEnum.openRequestDetail;
      default:
        return null;
    }
  }

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    type = json['type'] is String ? int.parse(json['type']) : json['type'];
    typeId = json['type_id'] is String
        ? int.parse(json['type_id'])
        : json['type_id'];
    typeName = setEnum();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['type_id'] = typeId;
    return data;
  }
}
