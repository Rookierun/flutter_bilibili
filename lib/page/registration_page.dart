import 'package:flutter/material.dart';
import 'package:flutter_bilibili/dao/login_dao.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/app_bar.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false; //蒙眼图片
  bool? loginEnable;
  String? userName;
  String? pwd;
  String? rePwd;
  String? imoocId;
  String? orderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        print("跳转到登录页面");
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              onChanged: (text) {
                pwd = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              obscureText: true,
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              onChanged: (text) {
                rePwd = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              obscureText: true,
            ),
            LoginInput(
              "慕课网ID",
              "请输入你的慕课网用户ID",
              keyboardType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              "课程订单号",
              "请输入课程订单号的后四位",
              keyboardType: TextInputType.number,
              lineStretch: true,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                "注册",
                onPressed: checkParams,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (isNotEmpty(userName) &&
        isNotEmpty(pwd) &&
        isNotEmpty(rePwd) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  bool isNotEmpty(String? text) {
    return text != null && text.isNotEmpty;
  }

  void checkParams() {
    String? tips;
    if (pwd != rePwd) {
      tips = "两次密码输入不一致";
    } else if (orderId?.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }

  ///开始注册
  void send() async {
    try {
      var result =
          await LoginDao.registration(userName!, pwd!, imoocId, orderId);
      print(result);
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.toString());
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.toString());
    }
  }
}
