import 'package:flutter_mentor/models/tags.dart';

class Request {
  final int requestId;
  final Tags tag;
  final RequestStatus status;
  final String text;
  final RequestAssignmentStatus assignmentStatus;

  Request({
    this.requestId,
    this.tag,
    this.status,
    this.text,
    this.assignmentStatus,
  });

  factory Request.fromMap(Map<String, dynamic> json){
    return Request(
      requestId: json["requestId"],
      tag: json["tag"],
      status: RequestStatus.values[int.parse(json["status"])],
      text: json["text"],
      assignmentStatus: RequestAssignmentStatus.values[int.parse(json["assignmentStatus"])],
    );
  }
}

enum RequestStatus {
  inactive,
  active,
}

enum RequestAssignmentStatus {
  assigned,
  notAssigned,
}