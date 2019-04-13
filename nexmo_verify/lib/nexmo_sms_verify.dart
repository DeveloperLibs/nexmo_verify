import 'dart:async';

import 'package:nexmo_verify/basemodel.dart';
import 'package:nexmo_verify/model/nexmo_response.dart';
import 'package:nexmo_verify/networ_util.dart';

class NexmoSmsVerificationUtil {

  NexmoResponseListener _nexmoResponseListener;

  String apiKey;

  String apiSecret;

  String requestId;

  NetworkUtil _netUtil = NetworkUtil();

  static NexmoSmsVerificationUtil _instance =
      NexmoSmsVerificationUtil.internal();

  NexmoSmsVerificationUtil.internal();

  factory NexmoSmsVerificationUtil() => _instance;

  initNexmo(String apiKey, String apiSecret) {
    this.apiKey = apiKey;
    this.apiSecret = apiSecret;
  }

  Future<BaseModel> sendOtp(String number, String brand) {
    return _netUtil.post(
      NetworkUtil.BASE_URL +
          '/verify/json?api_key=$apiKey' +
          "&api_secret=$apiSecret" +
          "&number=$number" +
          "&brand=$brand",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    ).then((dynamic res) {
      var response = new BaseModel.parse(res);
      response.status = 200;
      this.requestId = response.nexmoResponse.request_id;
      return response;
    });
  }

  Future<BaseModel> resentOtp() {
    return _netUtil.post(
      NetworkUtil.BASE_URL +
          '/verify/control/json?api_key=$apiKey' +
          "&api_secret=$apiSecret" +
          "&request_id=$requestId" +
          "&cmd=trigger_next_event",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    ).then((dynamic res) {
      var response = new BaseModel.parse(res);
      response.status = 200;
      return response;
    });
  }

  Future<BaseModel> verifyOtp(String otp) {
    return _netUtil.post(
      NetworkUtil.BASE_URL +
          '/verify/check/json?api_key=$apiKey' +
          "&api_secret=$apiSecret" +
          "&request_id=$requestId" +
          "&code=$otp",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    ).then((dynamic res) {
      var response = new BaseModel.parse(res);
      response.status = 200;
      return response;
    });
  }

  Future<BaseModel> cancelOldRequest() {
    return _netUtil.post(
      NetworkUtil.BASE_URL +
          '/verify/control/json?api_key=$apiKey' +
          "&api_secret=$apiSecret" +
          "&request_id=$requestId" +
          "&cmd=cancel",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    ).then((dynamic res) {
      var response = new BaseModel.parse(res);
      response.status = 200;
      return response;
    });
  }



  void addCallback(NexmoResponseListener nexmoResponseListener) {
    _nexmoResponseListener = nexmoResponseListener;
  }
}

abstract class NexmoResponseListener {
  void nexmoSuccess(NexmoResponse nexmoResponse) {}

  void nexmoError() {}
}
