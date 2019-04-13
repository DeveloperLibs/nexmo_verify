
import 'package:nexmo_verify/model/nexmo_response.dart';

class BaseModel {

  int status;
  String message;
  String response;

  NexmoResponse nexmoResponse;

  BaseModel.map(dynamic obj) {
    if (obj != null) {
      this.status = obj["status"];
      if (status == null) {
        this.status = obj["status_code"];
      }
      this.message = obj["message"];
      this.response =
          obj["response"] != null ? obj["response"].toString() : null;
    }
  }


  BaseModel.parse(dynamic obj) {
    nexmoResponse = NexmoResponse.fromJson(obj);

  }

}
