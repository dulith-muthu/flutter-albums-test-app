final class ApiHelper {
  static const String _scheme = "https";
  static const String _host = "jsonplaceholder.typicode.com";

  static Uri buildUri(
      {required String path,
      required int userId,
      Map<String, dynamic>? queryParams}) {
    var qp = queryParams ?? {};
    qp.addEntries({"userId": "$userId"}.entries);
    var uri = Uri(
      scheme: _scheme,
      host: _host,
      path: path,
      queryParameters: qp,
    );
    return uri;
  }
}
