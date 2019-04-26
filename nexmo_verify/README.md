# nexmo_verify

A Nexmo Verify Rest API Flutter plugin.

## How can use it?

# 1. Create instance of Nexmo API handler and put apiKey and apiSecret. After that implement callbacks methods.

```
 NexmoSmsVerificationUtil _nexmoSmsVerificationUtil = NexmoSmsVerificationUtil();
    _nexmoSmsVerificationUtil.initNexmo("apiKey", "apiSecret");
    _nexmoSmsVerificationUtil.addCallback(this);
```y

# 2. Send otp to mobile number.

```
_nexmoSmsVerificationUtil
          .sendOtp(_teCountryCode.text + _teMobileNumber.text, "Flutter")
          .then((dynamic res) {
        nexmoSuccess((res as BaseModel).nexmoResponse);
      });
```y

# 3. Verify otp.

```
_nexmoSmsVerificationUtil
          .verifyOtp("OTP")
          .then((dynamic res) {});
```y
