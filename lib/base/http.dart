import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Http {
  static Dio _dio;
  static Dio get dio {
    if (_dio == null) {
      _dio = Dio();
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 192.168.0.103:8888";
        };
      };
      return _dio;
    } else {
      return _dio;
    }
  }

  static Future<Map> get(String url,
      [Map<String, dynamic> arg, Map headers]) async {
    Options options = Options();
    options.headers = headers;
    Response resp =
        (await Http.dio.get(url, queryParameters: arg, options: options));
    Map data = resp.data;
    if (data.containsKey("errorCode")) {
      data['code'] = data["errorCode"];
    }
    if (data["code"] == 0) {
      if (data.containsKey("data")) {
        return data["data"];
      } else {
        return data;
      }
    } else {
      AssertionError(data);
      return {};
    }
  }

  static Future<Map> post(String url, [Map arg, Map headers]) async {
    Options options = Options();
    options.headers = headers;
    Response resp = (await Http.dio.post(url, data: arg, options: options));
    Map data = resp.data;
    if (data["code"] == 0) {
      if (data.containsKey("data")) {
        return data["data"];
      } else {
        return data;
      }
    } else {
      AssertionError(data);
      return {};
    }
  }
}
