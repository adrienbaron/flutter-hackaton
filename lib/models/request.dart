import 'package:flutter_mentor/models/tags.dart';

class Request {
  final int requestId;
  final Tags tag;
  final RequestStatus status;
  final String text;
  final RequestAssignmentStatus assignmentStatus;
  final int userId;

  Request({
    this.requestId,
    this.tag,
    this.status,
    this.text,
    this.assignmentStatus,
    this.userId,
  });

  factory Request.fromMap(Map<String, dynamic> json){
    return Request(
      requestId: json["requestId"],
      tag: TagsHelper.fromText(json["tag"]),
      status: RequestStatus.values[json["status"]],
      text: json["text"],
      assignmentStatus: RequestAssignmentStatus.values[json["assignmentStatus"]],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toMap() => {
    "requestId": requestId,
    "status": status.index,
    "tag": tag.toString().split('.')[1],
    "text": text,
    "assignmentStatus": assignmentStatus.index,
    "userId": userId,
  };
}

enum RequestStatus {
  inactive,
  active,
}

enum RequestAssignmentStatus {
  assigned,
  notAssigned,
}
