import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse({"code": 0, "message": "success"} as T,
          request: request, statusCode: 1, statusMessage: "1", extra: "1");
    });
  }
}
