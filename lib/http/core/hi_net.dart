import 'package:flutter_bilibili/http/core/dio_adapter.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNet {
  static final HiNet _instance = HiNet._internal();

  factory HiNet() {
    return _instance;
  }
  HiNet._internal();
  //
  // static late HiNet _instance = HiNet._();
  //
  // HiNet._();
  //
  // static HiNet getInstance() {
  //   return _instance;
  // }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      printLog(e.data.runtimeType);
      printLog(response.runtimeType);
      // response = e.data;//这里不知道为啥不能这样赋值

      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
      return null;
    }
    var result = response.data;
    printLog(result);
    var status = response == null ? -1 : response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status == null ? -1 : status, result.toString(),
            data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    printLog('method:${request.httpMethod()}');
    request.addHeader("token", "123");
    printLog("header:${request.header}");
    return DioAdapter().send(request);
  }

  void printLog(log) {
    print("hi-net:${log}");
  }
}
