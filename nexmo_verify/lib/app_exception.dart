class AppException extends StateError {

  int _statusCode;

  AppException(String msg, this._statusCode) : super(msg);


}
