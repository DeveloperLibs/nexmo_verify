import 'package:json_annotation/json_annotation.dart';

part 'package:nexmo_verify/model/nexmo_response.g.dart';

@JsonSerializable()
class NexmoResponse extends Object {
  String request_id;
  String status;
  String error_text;

  NexmoResponse({this.request_id, this.status, this.error_text});

  factory NexmoResponse.fromJson(Map<String, dynamic> json) =>
      _$NexmoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NexmoResponseToJson(this);
}
