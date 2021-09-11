import 'package:flutter/material.dart';
import 'package:wali/business/writer.dart';
import 'package:wali/feishu/auth.dart';
import 'package:wali/widgets.dart';

class FeedbackPageDebug extends StatefulWidget {
  const FeedbackPageDebug({Key key}) : super(key: key);

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
      ],
    );
  }
}
