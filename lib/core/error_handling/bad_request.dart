import 'dart:convert';

class BadRequest {
  final int status;
  final String message;

  BadRequest({
    required this.status,
    required this.message,
  });

  factory BadRequest.fromRawJson(String str) =>
      BadRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BadRequest.fromJson(Map<String, dynamic> json) => BadRequest(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
