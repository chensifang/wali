import 'dart:convert';

import 'package:wali/base/http.dart';
import 'package:wali/feishu/api.dart';
import 'package:wali/feishu/auth.dart';

class Robot {
  static Future<void> sendTextMsg(String chatName, String text) async {
    var url =
        "https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=chat_id";
    var arg = {
      "msg_type": "post",
      "receive_id": await Api.getChatId(chatName),
      "content": json.encode(text)
    };

    await Http.post(url, arg, await Auth.getTenantHeader());
  }

  static Future<void> sendRichTextMsg(String chatName, String text) async {
    var text = {
      "zh_cn": {
        "title": "我是一个标题",
        "content": [
          [
            {"tag": "text", "text": "第一行"}
          ],
          [
            {"tag": "a", "href": "http://www.feishu.cn", "text": "测试"},
          ],
          [
            {
              "tag": "at",
              "user_id": "ou_a2354465564b420ffa10956848671325",
              "user_name": "陈四方"
            }
          ],
        ]
      }
    };
    var url =
        "https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=chat_id";
    var arg = {
      "msg_type": "post",
      "receive_id": await Api.getChatId(chatName),
      "content": json.encode(text)
    };

    await Http.post(url, arg, await Auth.getTenantHeader());
  }

  // 发送图片
  static Future<void> sendImageMsg(String chatName, String text) async {
    var url =
        "https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=chat_id";
    var arg = {
      "receive_id": await Api.getChatId(chatName),
      "content": json
          .encode({"image_key": "img_v2_576c9661-c640-4342-bab9-60e38f23e9bg"}),
      "msg_type": "image"
    };
    await Http.post(url, arg, await Auth.getTenantHeader());
  }
}
