class SuccessModel {
  int? statusCode = 200;
  dynamic response;
  String? message;

  SuccessModel({
    this.response,
    this.statusCode,
    this.message,
  });
}
