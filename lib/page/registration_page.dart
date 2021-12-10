import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        LoginInput("用户名", "请输入用户名"),
        LoginInput("密码", "请输入密码"),
        LoginInput("确认密码", "请再次输入密码"),
        LoginInput("慕课网ID", "请输入你的慕课网用户ID"),
        LoginInput("课程订单号", "请输入课程订单号的后四位"),
        LoginInput("课程订单号", "请输入课程订单号的后四位"),
        LoginInput("课程订单号", "请输入课程订单号的后四位"),
        LoginInput("课程订单号", "请输入课程订单号的后四位"),
        LoginInput("课程订单号", "请输入课程订单号的后四位"),
        LoginInput("课程订单号", "请输入课程订单号的后四位"),
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: LoginButton("注册"),
        )
      ],
    );
  }
}
