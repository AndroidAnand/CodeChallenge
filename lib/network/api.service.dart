import 'dart:convert';
import 'dart:io';
import 'package:code_challenge/network/base_service.dart';
import 'package:code_challenge/network/response/app_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
const apiCacheKey = 'apiCache';

class ApiService extends BaseService {

  Future<dynamic> setCacheResponse(String url, dynamic value) async {
    Box cache = await Hive.openBox<String>(apiCacheKey);
    await cache.put(url, json.encode(value));
  }

  Future<dynamic> getCacheResponse(String url) async {
    Box cache = await Hive.openBox<String>(apiCacheKey);
    return json.decode(cache.get(url));
  }

  @override
  Future<void> deleteCache() async {
    Box cache = await Hive.openBox<String>(apiCacheKey);
    cache.clear();
    //HopeLogger.i("Deleted API cache storage");
    return;
  }

  @override
  Future<dynamic> getResponse(String url, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true, bool cache = true}) async {
    dynamic responseJson;
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      final uri = Uri.parse(baseUrl + url).replace(queryParameters: queryParams);
      final headers = await getHttpHeaders(accept: accept, contentType: contentType, auth: auth);
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
      if (response.statusCode < 300 && cache) {
        await setCacheResponse(url, responseJson);
      }
    } else {
      responseJson = await getCacheResponse(url);
      if (responseJson == null) {
        throw FetchDataException('No Internet connection and no cached data available');
      }
    }
    return responseJson;
  }


  @override
  Future deleteResponse(String url, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true}) async {
    dynamic responseJson;

    try {
      final uri = Uri.parse(baseUrl + url).replace(queryParameters: queryParams);
      final Map<String, String> headers = await getHttpHeaders(accept: accept, contentType: contentType, auth: auth);
      final response = await http.delete(uri, headers: headers);

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true})  async {
    dynamic responseJson;
    try {
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      final Map<String, String> headers = await getHttpHeaders(accept: accept, contentType: contentType, auth: auth);
      final Response response =  await post(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @override
  Future patchResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams,
    bool accept = true, bool contentType = true, auth = true}) async {
    try {
      String jsonBody = json.encode(body);
      // AusGpLogger.i('Patch Request - $jsonBody');
      final encoding = Encoding.getByName('utf-8');
      final Map<String, String> headers = await getHttpHeaders(accept: accept, contentType: contentType, auth: auth);
      final Response response = await patch(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @override
  Future<Map<String, dynamic>> patchMapResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams, bool accept = true, bool contentType = true, auth = true}) async {
    try {
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      final Map<String, String> headers = await getHttpHeaders(accept: accept, contentType: contentType, auth: auth);
      final Response response = await patch(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  dynamic responseParser(Response response) {
    if(response.headers.containsKey("content-type")) {
      if (response.headers["content-type"]!.contains('text/html')){
        return response.body.toString();
      } else if (response.headers["content-type"]!.contains('application/json')){
        return jsonDecode(response.body.toString());
      } else {
        return response.body.toString();
      }
    }
    return {};
  }

  dynamic returnResponse(Response response) {
    if(response.statusCode < 300){
      switch (response.statusCode) {
        case 200:
        case 201:
          return responseParser(response);
        case 204:
          return {};
        default:
          return responseParser(response);
      }
    } else if (response.statusCode < 400){
      return responseParser(response);
    } else {
      switch (response.statusCode) {
        case 400:
          if(response.headers["content-type"]!.contains('application/json')){
            return BadRequestModel.fromJson(
                jsonDecode(response.body)
            );
          }
          else {
            throw BadRequestException(response.body.toString());
          }
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 422:
          return responseParser(response);
        case 404:
          throw NotFoundException(response.body.toString());
        case 409:
          if (response.body
              .toString()
              .isEmpty ||
              response.body.toString() == 'FAIL') {
            return {};
          }
          dynamic responseJson = jsonDecode(response.body.toString());
          return responseJson;
        case 500:
        default:
          throw FetchDataException(
              'Error occured while communication with server' +
                  ' with status code : ${response.statusCode}');
      }
    }
  }

  Future<Map<String, String>> getHttpHeaders ({accept = true, contentType = true, auth = true}) async {
    String? accessToken;
    if(auth) {
      //accessToken = await UserSession.getAccessToken();
      // AusGpLogger.i("ACCESS TOKEN FOUND -> ${accessToken != null}");
    }
    return {
      if (contentType) 'Content-Type': 'application/json',
      if (accept) 'Accept': 'application/json',
      if (auth) 'x-api-key': 'sA,{tzUD=]dHvYNBJ4xVZ3c=&zS%.UqVc{But?kc',
      if (auth) 'User-Agent': 'com.stagingcupid.api/10.16.6 (Release) Android/31',
    };
  }

  @override
  Future putResponse(String url, Map<String, dynamic> body, {Map<String, dynamic>? queryParams, bool accept = true, bool contentType = true, auth = true}) async {
    dynamic responseJson;
    try {
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');
      final Map<String, String> headers = await getHttpHeaders(accept: accept, contentType: contentType, auth: auth);
      //     Uri url,
      // {Map<String, String>? headers, Object? body, Encoding? encoding
      final Response response =  await put(
        Uri.parse(baseUrl + url),
        headers: headers,
        body: jsonBody,
        encoding: encoding,
      );
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }
}

class BadRequestModel {
  String message;
  final int code;

  List<dynamic> allMessages;

  BadRequestModel({
    required this.message,
    required this.code,
    required this.allMessages
  });

  factory BadRequestModel.fromJson(Map<String, dynamic> json) {
    dynamic dynMessage = json["message"];
    final int code = json["code"] ?? 0;
    List<dynamic> messageList = [];
    String message;
    if(dynMessage is List) {
      messageList = dynMessage;
      message = dynMessage[0];
    } else {
      messageList.add(dynMessage);
      message = dynMessage;
    }

    return BadRequestModel(
        message: message,
        code: code,
        allMessages: messageList
    );
  }

  @override
  String toString() {
    return 'BadRequest - Code:$code, Message:$allMessages';
  }
}

