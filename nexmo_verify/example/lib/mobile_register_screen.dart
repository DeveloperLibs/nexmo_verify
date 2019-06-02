import 'package:flutter/material.dart';
import 'package:nexmo_verify/basemodel.dart';
import 'package:nexmo_verify/model/nexmo_response.dart';
import 'package:nexmo_verify/nexmo_sms_verify.dart';
import 'package:nexmo_verify_example/otp_verification_screen.dart';
import 'package:nexmo_verify_example/progress_hud.dart';

class MobileNumberVerifyScreen extends StatefulWidget {
  MobileNumberVerifyScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<MobileNumberVerifyScreen> {
  bool _isLoading = false;
  final _teCountryCode = TextEditingController();
  final _teMobileNumber = TextEditingController();

  FocusNode _focusNodeFirstName = FocusNode();
  NexmoSmsVerificationUtil _nexmoSmsVerificationUtil;

  @override
  void dispose() {
    _teCountryCode.dispose();
    _teMobileNumber.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nexmoSmsVerificationUtil = NexmoSmsVerificationUtil();
    _nexmoSmsVerificationUtil.initNexmo("apiKey", "apiSecret");
    _teCountryCode.text = "91";
  }

  void _submit() {
    if (_teCountryCode.text.isNotEmpty && _teMobileNumber.text.isNotEmpty) {
      showLoader();
      _nexmoSmsVerificationUtil
          .sendOtp(_teCountryCode.text + _teMobileNumber.text, "Flutter")
          .then((dynamic res) {
        closeLoader();
        nexmoSuccess((res as BaseModel).nexmoResponse);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: FractionalOffset.center,
          margin: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 100.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1.0),
            border: Border.all(color: Color(0x33A6A6A6)),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Country"),
                controller: _teCountryCode,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Mobile Number"),
                controller: _teMobileNumber,
                focusNode: _focusNodeFirstName,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        RaisedButton(
          color: Color(0xFFFFA600),
          onPressed: _submit,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Text(
            "OTP",
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ],
    );

    var screenRoot = Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: loginForm,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFF1F1EF),
      body: ProgressHUD(
        child: screenRoot,
        inAsyncCall: _isLoading,
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() => _isLoading = false);
  }

  @override
  void closeLoader() {
    setState(() => _isLoading = false);
  }

  @override
  void showLoader() {
    setState(() => _isLoading = true);
  }

  @override
  String getMobile() {
    return _teMobileNumber.text.toString();
  }

  @override
  void nexmoSuccess(NexmoResponse nexmoResponse) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OtpVerificationScreenState(
                _teCountryCode.text + _teMobileNumber.text)));
  }
}
