
class ResponseModel {
  ResponseModel({
    this.success,
    this.message,
  });

  late final bool? success;
  late final String? message;

  ResponseModel.fromJson(Map<String, dynamic>? json) {
    success = json?['success'] as bool;
    message = json?['message'] as String;
  }
}

