import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ETPHttp {
  Future<void> get(String url,
      {Function(dynamic) successCallback,
      Function(dynamic) errorCallback,
      Function(dynamic) loadingCallback}) async {
    loadingCallback?.call(true);
    http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).then((response) {
      // debugPrint("----------------------------------");
      // debugPrint("Method : ${response.request.method}");
      // debugPrint("Header : ${response.request.headers}");
      // debugPrint("Request : ${response.request}");
      // debugPrint("StatusCode : ${response.statusCode}");
      // debugPrint("Response Body : ${response.body}");
      // debugPrint("----------------------------------");

      if (response.statusCode == 200) {
        successCallback?.call(response.body);
      } else if (response.statusCode == 401) {
        //logout
      } else {
        errorCallback?.call("Hata");
      }
    }).catchError((e) {
      errorCallback(exceptionHandler(e));
    }).whenComplete(() => loadingCallback?.call(false));
  }

  String exceptionHandler(e) {
    switch (e.runtimeType) {
      case SocketException:
        {
          return "İnternet Bağlantısını Kontrol Edin.";
        }

        break;
      case TimeoutException:
        {
          return "Servise erişemiyorum";
        }
        break;
      default:
        {
          return "Birşey oldu! $e";
        }
    }
  }

  void post(String url,
      {dynamic body,
      Function(dynamic) successCallback,
      Function(dynamic) errorCallback,
      Function(dynamic) loadingCallback}) async {
    loadingCallback(true);
    http.post(url, body: jsonEncode(body.toJson()), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).then((response) {
      // debugPrint("----------------------------------");
      // debugPrint("Method : ${response.request.method}");
      // debugPrint("Header : ${response.request.headers}");
      // debugPrint("Request : ${response.request}");
      // debugPrint("StatusCode : ${response.statusCode}");
      // debugPrint("Response Body : ${response.body}");
      // debugPrint("----------------------------------");

      if (response.statusCode == 200) {
        successCallback?.call(response.body);
      } else if (response.statusCode == 401) {
        //logout
      } else {
        errorCallback?.call("Hata");
      }
    }).catchError((e) {
      errorCallback(exceptionHandler(e));
    }).whenComplete(() => loadingCallback?.call(false));
  }
}
