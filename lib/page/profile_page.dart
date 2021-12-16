import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';

class ProfilePage extends StatefulWidget {
  String name = "123";
  ProfilePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends HiState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('我的${widget.name}'),
      ),
    );
  }
}
