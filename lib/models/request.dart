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
}

enum RequestStatus {
  inactive,
  active,
}

enum RequestAssignmentStatus {
  assigned,
  notAssigned,
}