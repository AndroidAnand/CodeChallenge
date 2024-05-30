import 'package:code_challenge/config/environment.dart';
import 'package:code_challenge/network/api.service.dart';

abstract class BaseService {
  final String baseUrl = Environment.apiBaseUrl;

  Future<void> deleteCache();

  Future <dynamic> getResponse(String url, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true, bool cache = true});
  Future <dynamic> deleteResponse(String url, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true});
  Future <dynamic> postResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true});
  Future<dynamic> patchResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true});
  Future<dynamic> putResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true});
  Future<Map<String, dynamic>> patchMapResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true});

  BaseService();

  factory BaseService.getInstance() {
    return ApiService();
  }
}