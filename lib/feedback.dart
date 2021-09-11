import 'package:flutter/material.dart';
import 'package:wali/business/writer.dart';
import 'package:wali/feishu/auth.dart';
import 'package:wali/share.dart';
import 'package:wali/widgets.dart';

// ignore: must_be_immutable
class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: contents());
  }

  // 添加控件
  Column contents() {
    return Column(
      children: [
        TextInput(
          hintText: "请输入 Code",
          text: Prefs.getString("code"),
          onChange: (text) {
            Prefs.setString("code", text);
          },
        ),
        Btn(
          title: "跳转 Code",
          action: () {
            schemeToCode();
          },
        ),
        WText(title: Prefs.getString("userToken")),
        Btn(
          title: "刷新 userToken",
          action: () {
            Auth.getUserToken().then((value) {
              setState(() {});
            });
          },
        ),
        TextInput(
          hintText: "请输入 Sheet",
          text: Prefs.getString("sheet"),
          onChange: (text) {
            Prefs.setString("sheet", text);
          },
        ),
        Btn(
          title: "写入反馈表",
          action: () {
            Writer.write();
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
          text: Prefs.getString("group"),
          onChange: (text) {
            Prefs.setString("group", text);
          },
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
        Btn(
          title: "刷新 token",
          action: () {
            Auth.refreshUserToken().then((value) {
              setState(() {});
            });
          },
        ),
      ],
    );
  }
}
