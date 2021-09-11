import 'package:wali/feishu/auth.dart';
import 'package:wali/base/http.dart';

class Api {
  static Future<List> readNormalTable(String sheetToken, String ranges) async {
    String url =
        "https://open.feishu.cn/open-apis/sheets/v2/spreadsheets/$sheetToken/values_batch_get";
    Map<String, String> arg = {"ranges": ranges};
    Map resp = await Http.get(url, arg, Auth.getUserHeader());
    return resp["valueRanges"][0]["values"];
  }

//  读多维表格
  static Future<List> readManyTable(tokens) async {
    // 获取表数据
    String url =
        "https://open.feishu.cn/open-apis/bitable/v1/apps/${tokens[0]}/tables/${tokens[1]}/records";
    var resp = await Http.get(url, null, Auth.getUserHeader());
    var items = resp["items"];
    return items;
  }

  // 写多维表格
  static void writeManyTable(List records, List tokens) async {
    if (records.length == 0) {
      print("无数据");
      return;
    } else {
      var url =
          "https://open.feishu.cn/open-apis/bitable/v1/apps/${tokens[0]}/tables/${tokens[1]}/records/batch_create?user_id_type=user_id";
      var arg = {"records": records};
      Map resp = await Http.post(url, arg, Auth.getUserHeader());
      if (resp['code'] == 0) {
        print("写入成功");
      } else {
        print("写入失败");
      }
    }
  }

  // 获取群 id
  static Future<String> getChatId(String name) async {
    var url = "https://open.feishu.cn/open-apis/chat/v4/list";
    var resp = await Http.get(url, null, await Auth.getTenantHeader());
    var group = resp["groups"];
    var chatId = "";
    for (var g in group) {
      if (g["name"] == name) {
        chatId = g["chat_id"];
      }
    }
    print(chatId);
    return chatId;
  }
}




// resp = request.get(url=url, headers=auth.get_user_header())
// items = resp["items"]
// return items