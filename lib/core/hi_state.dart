import 'package:flutter/material.dart';

///页面状态异常管理
abstract class HiState<T extends StatefulWidget> extends State {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print("HiState:页面已销毁，取消本次setState执行：${toString()}");
    }
  }
}
