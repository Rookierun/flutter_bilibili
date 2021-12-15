import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/registration_request.dart';

class LoginDao {
  static String BOARDING_PASS = "boarding-pass";

  static login(String userName, String pwd) {
    return _send(userName, pwd);
  }

  static registration(String userName, String pwd, imoocId, orderId) {
    return _send(userName, pwd, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String pwd, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      // 注册
      request = RegistrationRequest();
    } else {
      //登录
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", pwd)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var result = await HiNet().fire(request);
    if (result["code"] == 0 && result["data"] != null) {
      HiCache.getInstance().setString(BOARDING_PASS, result["data"]);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
