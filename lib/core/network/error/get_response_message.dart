class GetResponseMessage {
  String getResponseMessage(dynamic body) {
    if (body is Map) {
      final data = body['data'];

      if (data is Map) {
        for (final value in data.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
        }
      }
    }
    if (body['message'] != null) {
      return body['message'].toString();
    }
    return "An unknown error occurred.";
  }
}
