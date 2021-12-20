import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/owner.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/format_util.dart';

class VideoHeader extends StatelessWidget {
  final Owner owner;

  const VideoHeader(this.owner, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  owner.face ?? "",
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      owner.name ?? "",
                      style: const TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    Text(
                      countFormat(owner.fans ?? 0),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            height: 24,
            minWidth: 50,
            onPressed: () {
              print("---关注--");
            },
            color: primary,
            child: const Text(
              " + 关注",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
