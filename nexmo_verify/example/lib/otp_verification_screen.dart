import 'package:flutter/material.dart';
import 'package:nexmo_verify/nexmo_sms_verify.dart';
import 'package:nexmo_verify_example/count/countdown_base.dart';
import 'package:nexmo_verify_example/widgets/custom_button.dart';
import 'package:nexmo_verify_example/widgets/custom_text_field.dart';
import 'package:nexmo_verify_example/widgets/progress_hud.dart';

class OtpVerificationScreenState extends StatefulWidget {

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();

}

class _OtpVerificationScreenState extends State<OtpVerificationScreenState> {

  bool _isLoading = false;
  bool _isResendEnable = false;
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String otpWaitTimeLabel = "";
  bool _isMobileNumberEnter = false;

  final _teOtpDigitOne = TextEditingController();
  final _teOtpDigitTwo = TextEditingController();
  final _teOtpDigitThree = TextEditingController();
  final _teOtpDigitFour = TextEditingController();

  FocusNode _focusNodeDigitOne = new FocusNode();
  FocusNode _focusNodeDigitTwo = new FocusNode();
  FocusNode _focusNodeDigitThree = new FocusNode();
  FocusNode _focusNodeDigitFour = new FocusNode();

  CustomButton _customButton;

  NexmoSmsVerificationUtil _nexmoSmsVerificationUtil;

  static const TextStyle linkStyle = const TextStyle(
    color: const Color(0xFF8C919E),
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    _customButton = new CustomButton();
    changeFocusListener(_teOtpDigitOne, _focusNodeDigitTwo);
    changeFocusListener(_teOtpDigitTwo, _focusNodeDigitThree);
    changeFocusListener(_teOtpDigitThree, _focusNodeDigitFour);

    removeDigitListener(_teOtpDigitOne, _focusNodeDigitOne);
    removeDigitListener(_teOtpDigitTwo, _focusNodeDigitTwo);
    removeDigitListener(_teOtpDigitThree, _focusNodeDigitThree);
    removeDigitListener(_teOtpDigitFour, _focusNodeDigitFour);

    checkFiled(_teOtpDigitOne);
    checkFiled(_teOtpDigitTwo);
    checkFiled(_teOtpDigitThree);
    checkFiled(_teOtpDigitFour);
    startTimer();

    _nexmoSmsVerificationUtil = NexmoSmsVerificationUtil();
    _nexmoSmsVerificationUtil.initNexmo("69b6b0a6", "ad7142edeb933067");
  }

  void checkFiled(TextEditingController teOtpDigitOne) {
    teOtpDigitOne.addListener(() {
      if (!teOtpDigitOne.text.isEmpty &&
          !_teOtpDigitTwo.text.isEmpty &&
          !_teOtpDigitThree.text.isEmpty &&
          !_teOtpDigitFour.text.isEmpty) {
        _isMobileNumberEnter = true;
      } else {
        _isMobileNumberEnter = false;
      }
      setState(() {});
    });
  }

  void _submit() {
    if (_isMobileNumberEnter) {
      _nexmoSmsVerificationUtil
          .verifyOtp(_teOtpDigitOne.text +
              _teOtpDigitTwo.text +
              _teOtpDigitThree.text +
              _teOtpDigitFour.text)
          .then((dynamic res) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var msg = new RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        children: <TextSpan>[
          const TextSpan(text: 'Enter one time password ('),
          new TextSpan(
            text: 'OTP',
          ),
          const TextSpan(
            text: ') sent via ',
          ),
          new TextSpan(
            text: 'SMS',
          ),
        ],
      ),
    );

    var otpBox = new Padding(
        padding: EdgeInsets.only(left: 80.0, right: 80.0),
        child: new Row(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(left: 10.0)),
            new CustomTextField(
                    inputBoxController: _teOtpDigitOne,
                    focusNod: _focusNodeDigitOne,
                    keyBoardType: TextInputType.number,
                    textColor: 0xFFA6A6A6,
                    textSize: 14.0,
                    textFont: "Nexa_Bold",
                    maxLength: 1,
                    textAlign: TextAlign.center)
                .textField("", ""),
            new Padding(padding: EdgeInsets.only(left: 10.0)),
            new CustomTextField(
                    inputBoxController: _teOtpDigitTwo,
                    focusNod: _focusNodeDigitTwo,
                    keyBoardType: TextInputType.number,
                    textColor: 0xFFA6A6A6,
                    textSize: 14.0,
                    textFont: "Nexa_Bold",
                    maxLength: 1,
                    textAlign: TextAlign.center)
                .textField("", ""),
            new Padding(padding: EdgeInsets.only(left: 10.0)),
            new CustomTextField(
                    inputBoxController: _teOtpDigitThree,
                    focusNod: _focusNodeDigitThree,
                    keyBoardType: TextInputType.number,
                    textColor: 0xFFA6A6A6,
                    textSize: 14.0,
                    textFont: "Nexa_Bold",
                    maxLength: 1,
                    textAlign: TextAlign.center)
                .textField("", ""),
            new Padding(padding: EdgeInsets.only(left: 10.0)),
            new CustomTextField(
                    inputBoxController: _teOtpDigitFour,
                    focusNod: _focusNodeDigitFour,
                    keyBoardType: TextInputType.number,
                    textColor: 0xFFA6A6A6,
                    textSize: 14.0,
                    textFont: "Nexa_Bold",
                    maxLength: 1,
                    textAlign: TextAlign.center)
                .textField("", ""),
          ],
        ));

    var form = new Column(
      children: <Widget>[
        new Container(
          alignment: FractionalOffset.center,
          margin: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 0.0),
          decoration: new BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(6.0),
                topRight: const Radius.circular(6.0)),
          ),
          child: new Column(
            children: <Widget>[
              new Container(
                alignment: FractionalOffset.center,
                padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 50.0),
                decoration: new BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  border: Border.all(color: const Color(0x33A6A6A6)),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(6.0),
                      topRight: const Radius.circular(6.0)),
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
                        "OTP VERIFICATION",
                      ),
                      new Padding(
                        padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 10.0),
                        child: msg,
                      ),
                      new SizedBox(
                        width: 0.0,
                        height: 20.0,
                      ),
                      new Text(
                        "OTP",
                      ),
                      otpBox,
                      new SizedBox(
                        width: 0.0,
                        height: 20.0,
                      ),
                      new Text(
                        otpWaitTimeLabel,
                      ),
                      new GestureDetector(
                        onTap: () {
                          _resendOtp();
                        },
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 0.0),
                          child: _isResendEnable
                              ? _customButton.buttonMedium(
                                  "RESEND OTP",
                                  EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  Colors.blueGrey,
                                  const Color(0xFF28324E),
                                  10.0)
                              : _customButton.buttonMedium(
                                  "RESEND OTP",
                                  EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                  Colors.blue,
                                  const Color(0xFF28324E),
                                  10.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        new GestureDetector(
          onTap: () {
            _submit();
          },
          child: new Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
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
      child: new SingleChildScrollView(
        child: new Stack(
          children: <Widget>[
            form,
          ],
        ),
      ),
    );

    return new WillPopScope(
        onWillPop: () async {
          print("back");
          return true;
        },
        child: new Scaffold(
          backgroundColor: const Color(0xFFF1F1EF),
          appBar: null,
          key: _scaffoldKey,
          body: ProgressHUD(
            child: screenRoot,
            inAsyncCall: _isLoading,
            opacity: 0.0,
          ),
        ));
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() => _isLoading = false);
  }

  void removeDigitListener(
      TextEditingController controller, FocusNode focusNode) {
//    focusNode.addListener(() {
//      if (controller.text.length > 0 && controller != null) {
//        controller.text = "";
//      }
//      setState(() {});
//    });
  }

  void changeFocusListener(
      TextEditingController teOtpDigitOne, FocusNode focusNodeDigitTwo) {
    teOtpDigitOne.addListener(() {
      if (teOtpDigitOne.text.length > 0 && focusNodeDigitTwo != null) {
        FocusScope.of(context).requestFocus(focusNodeDigitTwo);
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

  void _resendOtp() {
    if (_isResendEnable) {
//      _presenter.sendRequestOtp(userSignUpInfo.mobile);
    }
  }

  @override
  void moveToReferralScreen() {
//    new AnimationUtil().slideAnim(
//        ReferralScreen(userSignUpInfo: userSignUpInfo),
//        context,
//        false,
//        RouteSettings(name: "/ReferralScreen"));
  }

  void startTimer() {
    setState(() {
      _isResendEnable = false;
    });

    var sub =  CountDown(new Duration(minutes: 5)).stream.listen(null);

    sub.onData((Duration d) {
      setState(() {
        int sec = d.inSeconds % 60;
        otpWaitTimeLabel = d.inMinutes.toString() + ":" + sec.toString();
      });
    });

    sub.onDone(() {
      setState(() {
        _isResendEnable = true;
      });
    });
  }

  @override
  void optSent() {
    startTimer();
  }

  @override
  void mobileVerified() {
    moveToReferralScreen();
  }

  @override
  void showAlert(String msg) {}
}
