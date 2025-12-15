import 'package:http/http.dart' as http;
import 'token_storage.dart';

class AuthClient extends http.BaseClient {
  final http.Client _inner;
  AuthClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = TokenStorage.accessToken;
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return _inner.send(request);
  }
}
