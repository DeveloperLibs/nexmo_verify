import 'package:flutter/material.dart';
import 'package:nexmo_verify/basemodel.dart';
import 'package:nexmo_verify/model/nexmo_response.dart';
import 'package:nexmo_verify/nexmo_sms_verify.dart';
import 'package:nexmo_verify_example/otp_verification_screen.dart';
import 'package:nexmo_verify_example/widgets/custom_button.dart';
import 'package:nexmo_verify_example/widgets/custom_text_field.dart';
import 'package:nexmo_verify_example/widgets/progress_hud.dart';

class MobileRegisterScreenState extends StatefulWidget {
  MobileRegisterScreenState();

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<MobileRegisterScreenState>
    implements NexmoResponseListener {
  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isMobileNumberEnter = false;
  final _teCountryCode = TextEditingController();
  final _teMobileNumber = TextEditingController();
  FocusNode _focusNodeFirstName = new FocusNode();
  CustomButton _customButton;
  NexmoSmsVerificationUtil _nexmoSmsVerificationUtil;

  static const TextStyle linkStyle = const TextStyle(
    color: const Color(0xFF8C919E),
    fontWeight: FontWeight.bold,
  );

  _LoginScreenState();

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
    _nexmoSmsVerificationUtil.addCallback(this);
    _customButton = new CustomButton();
    _teCountryCode.text = "91";
    setPasswordListener();
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _nexmoSmsVerificationUtil
          .sendOtp(_teCountryCode.text + _teMobileNumber.text, "Flutter")
          .then((dynamic res) {
        nexmoSuccess((res as BaseModel).nexmoResponse);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          alignment: FractionalOffset.center,
          margin: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 100.0),
          decoration: new BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1.0),
            border: Border.all(color: const Color(0x33A6A6A6)),
            borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
          ),
          child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  width: 0.0,
                  height: 30.0,
                ),
                new Text(
                  "YOUR MOBILE NUMBER",
                ),
                new CustomTextField(
                  inputBoxController: _teCountryCode,
                  textColor: 0xFFA6A6A6,
                  textSize: 14.0,
                  textFont: "Nexa_Bold",
                ).textFieldWithOutPrefix("Country", ""),
                new CustomTextField(
                  inputBoxController: _teMobileNumber,
                  focusNod: _focusNodeFirstName,
                  keyBoardType: TextInputType.number,
                  textColor: 0xFFA6A6A6,
                  textSize: 14.0,
                  textFont: "Nexa_Bold",
                  maxLength: 15,
                ).textFieldWithOutPrefix("MOBILE NUMBER", "MOBILE NUMBER"),
              ],
            ),
          ),
        ),
        new GestureDetector(
          onTap: () {
            _submit();
          },
          child: new Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: _isMobileNumberEnter
                ? _customButton.buttonWithColorBg(
                    "NEXT",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    const Color(0xFFFFD900),
                    const Color(0xFF28324E))
                : _customButton.getAppBorderButton(
                    "NEXT",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  ),
          ),
        ),
      ],
    );

    var screenRoot = new Container(
      height: double.infinity,
      child: new SingleChildScrollView(
        child: new Center(
          child: loginForm,
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: const Color(0xFFF1F1EF),
      appBar: null,
      key: _scaffoldKey,
      body: ProgressHUD(
        child: screenRoot,
        inAsyncCall: _isLoading,
        opacity: 0.0,
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() => _isLoading = false);
  }

  void setPasswordListener() {
    _teMobileNumber.addListener(() {
      if (_teMobileNumber.text.isEmpty) {
        _isMobileNumberEnter = false;
      } else {
        _isMobileNumberEnter = true;
      }
      setState(() {});
    });
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
  void nexmoError() {}

  @override
  void nexmoSuccess(NexmoResponse nexmoResponse) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => OtpVerificationScreenState()));
  }
}
