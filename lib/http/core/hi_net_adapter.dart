import 'dart:convert';

import 'package:flutter_bilibili/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

/// 统一网络层返回格式
class HiNetResponse<T> {
  BaseRequest? request;
  late T data;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  HiNetResponse(this.data,
      {this.request, this.statusCode, this.statusMessage, this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
