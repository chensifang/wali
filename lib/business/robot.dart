import 'dart:convert';

import 'package:wali/base/http.dart';
import 'package:wali/feishu/api.dart';
import 'package:wali/feishu/auth.dart';

class Robot {
  static Future<void> sendTextMsg(String chatName, String text) async {
    var url =
        "https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=chat_id";
    var arg = {
      "msg_type": "text",
      "receive_id": await Api.getChatId(chatName),
      "content": json.encode({"text": text})
    };

    await Http.post(url, arg, await Auth.getTenantHeader());
  }
}
