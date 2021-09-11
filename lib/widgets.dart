import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ignore: must_be_immutable
class Btn extends StatelessWidget {
  String title;
  Function action;
  Btn({Key key, this.title = "", this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _width = size.width;
    final bottonHeight = 30.0;
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 10),
        child: SizedBox(
          width: _width,
          height: bottonHeight,
          child: TextButton(
            onPressed: () {
              this.action();
            },
            child: Text(
              title,
              style: TextStyle(fontSize: 13),
            ),
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
          ),
        ));
  }
}

// 输入框
// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  String hintText;
  String text;
  Function onChange;
  TextInput({Key key, this.hintText, this.text, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _width = size.width;
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 10),
        color: Colors.white10,
        child: SizedBox(
          width: _width,
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
            controller: TextEditingController(text: text),
            onChanged: (text) {
              onChange(text);
            },
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: hintText.substring(
                  hintText.contains(" ") ? 4 : 3, hintText.length),
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
          ),
        ));
  }
}

// Text
// ignore: must_be_immutable
class WText extends StatelessWidget {
  String title;
  WText({Key key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: Text(
        title,
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
