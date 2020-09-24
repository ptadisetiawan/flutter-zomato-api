import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/core/services/base/config_services.dart';
import 'package:foodfinder/core/utils/auth_utils.dart';
import 'package:foodfinder/core/utils/dialog_utils.dart';
import 'package:foodfinder/ui/router/router_generator.dart';

enum RequestType { GET, POST, DELETE }

class BaseServices {
  Dio _dio = new Dio();
  Options _headerOption;

  Future _getToken() async {
    var _token = await AuthUtils.instance.getToken();
    _headerOption = ConfigServices.getHeaders(token: _token);
  }

  Future<dynamic> request(String url, RequestType type, BuildContext context,
      {dynamic data, bool useToken}) async {
    var response;
    // if this route use token then fetch token
    if (useToken != null && useToken) {
      await _getToken();
    } else {
      _headerOption = ConfigServices.getHeaders();
    }

    try {
      switch (type) {
        case RequestType.POST:
          response = await _dio.post(url,
              data: data != null ? data : null, options: _headerOption);
          break;
        case RequestType.GET:
          response = await _dio.post(url, options: _headerOption);
          break;
        case RequestType.DELETE:
          response = await _dio.delete(url,
              data: data != null ? data : null, options: _headerOption);
          break;
      }
    } on DioError catch (e) {
      response = e.response;
    }
    // handling error and status code
    response = json.decode(response.toString());

    // if 401 then return to login
    if (response["code"] == 403) {
      DialogUtils.instance.showInfo(
          context,
          "Session Expired, silahkan masukkan api key yang valid",
          Icons.error,
          "OK", onClick: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, RouterGenerator.routeHome, (route) => false);
      });
      return null;
    }
    return response;
  }
}
