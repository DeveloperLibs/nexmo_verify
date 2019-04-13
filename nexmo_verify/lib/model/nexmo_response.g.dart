part of 'nexmo_response.dart';

NexmoResponse _$NexmoResponseFromJson(Map<String, dynamic> json) {
  return NexmoResponse(
      request_id: json['request_id'] as String,
      status: json['status'] as String,
      error_text: json['error_text'] as String);
}

Map<String, dynamic> _$NexmoResponseToJson(NexmoResponse instance) => <String, dynamic>{
      'request_id': instance.request_id,
      'status': instance.status,
      'error_text': instance.error_text
    };
