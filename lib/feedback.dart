import 'package:flutter/material.dart';
import 'package:wali/widgets.dart';

// ignore: must_be_immutable
class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);
  String userToken;
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: contents(widget.userToken));
  }

  // 添加控件
  Column contents(String userToken) {
    return Column(
      children: [
        TextInput(
          hintText: "请输入 Code",
          text: "",
        ),
        Btn(
          title: "跳转 Code",
          action: () {
            setState(() {
              // todo
            });
          },
        ),
        WText(title: userToken ?? ""),
        Btn(
          title: "刷新 userToken",
          action: () {
            setState(() {
              // todo
            });
          },
        ),
        TextInput(
          hintText: "请输入 Sheet",
          text: "",
        ),
        Btn(
          title: "写入反馈表",
          action: () {
            setState(() {
              // todo
            });
          },
        ),
        Btn(
          title: "关卡",
          action: () {
            setState(() {
              // todo
            });
          },
        ),
        TextInput(
          hintText: "请输入群组",
          text: "",
        ),
        Btn(
          title: "发反馈到群",
          action: () {
            setState(() {
              // todo
            });
          },
        ),
        Btn(
          title: "绘图",
          action: () {
            setState(() {
              // todo
            });
          },
        ),
      ],
    );
  }
}
