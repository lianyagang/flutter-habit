class ResponseException implements Exception {
  final code;
  final message;
  final errorData;

  ResponseException({this.code, this.message, this.errorData});

  String toString() {
    if (message == null) return "Exception";
    return "$message errorData $errorData}";
  }
}
