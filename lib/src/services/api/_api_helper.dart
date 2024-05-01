final class ApiHelper {
  static const String _scheme = "https";
  static const String _host = "jsonplaceholder.typicode.com";

  static Uri buildUri(
      {required String path, int? userId, Map<String, dynamic>? queryParams}) {
    if (userId != null) {
      queryParams = queryParams ?? {};
      queryParams.addEntries({"userId": "$userId"}.entries);
    }
    var uri = Uri(
      scheme: _scheme,
      host: _host,
      path: path,
      queryParameters: queryParams,
    );
    return uri;
  }
}
