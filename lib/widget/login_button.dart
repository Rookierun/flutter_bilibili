import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color.dart';

class LoginButton extends StatefulWidget {
  final String title;
  bool enable = true;
  final VoidCallback? onPressed;

  LoginButton(this.title, {Key? key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: widget.enable ? widget.onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
