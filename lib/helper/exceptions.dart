

class ApiException implements Exception{

  final message;

  ApiException([this.message]);

  String toString() {
    if (message == null) return "Exception";
    return "$message";
  }
}