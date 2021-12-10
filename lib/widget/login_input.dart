import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged; //数值变化的回调
  final ValueChanged<bool>? focusChanged; //焦点变化的回调
  final bool lineStretch; //分割线是否撑满
  final bool obscureText; //是否是密文，用于密码的输入
  final TextInputType keyboardType;

  LoginInput(this.title, this.hint,
      {this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType = TextInputType.text}); //键盘类型，数字/字母/等等

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Has focus:${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.lineStretch ? 0 : 15),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
