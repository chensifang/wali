import 'package:flutter/material.dart';
import 'package:wali/business/robot.dart';
import 'package:wali/business/writer.dart';
import 'package:wali/feishu/api.dart';
import 'package:wali/feishu/auth.dart';
import 'package:wali/share.dart';
import 'package:wali/widgets.dart';

// ignore: must_be_immutable
class FeedbackPageDebug extends StatefulWidget {
  FeedbackPageDebug({Key key}) : super(key: key);
  String chatName;
  String text;
  @override
  _FeedbackPageDebugState createState() => _FeedbackPageDebugState();
}

class _FeedbackPageDebugState extends State<FeedbackPageDebug> {
  @override
  Widget build(BuildContext context) {
    return Container(child: contents());
  }

  // 添加控件
  Column contents() {
    return Column(
      children: [
        SizedBox(height: 20),
        Btn(
          title: "刷新 token",
          action: () {
            Auth.refreshUserToken().then((value) {
              setState(() {});
            });
          },
        ),
        Btn(
          title: "读反馈表",
          action: () {
            Writer.readWorkTable();
          },
        ),
        Btn(
          title: "写入反馈表",
          action: () {
            Writer.write();
          },
        ),
        TextInput(
          hintText: "请输入群组",
          text: Prefs.getString("debug_group"),
          onChange: (text) {
            Prefs.setString("debug_group", text);
          },
        ),
        TextInput(
          hintText: "请输入文字",
          text: Prefs.getString("debug_text"),
          onChange: (text) {
            Prefs.setString("debug_text", text);
          },
        ),
        Btn(
          title: "发送",
          action: () {
            Robot.sendTextMsg(
                Prefs.getString("debug_group"), Prefs.getString("debug_text"));
          },
        ),
        Btn(
          title: "获取群成员",
          action: () {
            Api.getChatMembers("瓦力");
          },
        ),
        Btn(
          title: "发图片",
          action: () {
            Robot.sendImageMsg("瓦力", null);
          },
        ),
      ],
    );
  }
}
