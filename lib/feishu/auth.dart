// 请求 tenant_access_token
import 'package:url_launcher/url_launcher.dart';
import 'package:wali/base/http.dart';
import 'package:wali/share.dart';

class Auth {
  static Future<String> getTenantToken() async {
    String url =
        "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/";
    Map arg = {
      "app_id": "cli_a02670ae80f9900e",
      "app_secret": "o7UtVoQFdawgz4yJJa8Jde6UQeuuLcgs"
    };
    var resp = await Http.post(url, arg, null);
    var token = resp["tenant_access_token"];
    return token;
  }

  static Future<Map> getTenantHeader() async {
    var tenantToken = await getTenantToken();
    var header = {
      "Authorization": "Bearer " + tenantToken,
      "Content-Type": "application/json; charset=utf-8"
    };
    return header;
  }

  static Future<String> getUserToken() async {
    var code = Prefs.getString("code");
    var url = "https://open.feishu.cn/open-apis/authen/v1/access_token";
    var arg = {"grant_type": "authorization_code", "code": code};
    var resp = await Http.post(url, arg, await getTenantHeader());
    var userToken = resp["access_token"];
    var refreshToken = resp["refresh_token"];
    saveUserToken(userToken, refreshToken);
    return userToken;
  }

// 刷新 token
  static Future<void> refreshUserToken() async {
    String url =
        "https://open.feishu.cn/open-apis/authen/v1/refresh_access_token";
    var arg = {
      "grant_type": "refresh_token",
      "refresh_token": Prefs.getString("refreshToken")
    };
    var resp = await Http.post(url, arg, await getTenantHeader());
    var userToken = resp["access_token"];
    var refreshToken = resp["refresh_token"];
    saveUserToken(userToken, refreshToken);
  }

  // 存储 token
  static void saveUserToken(String userToken, String refreshToken) {
    Prefs.setString("userToken", userToken);
    Prefs.setString("refreshToken", refreshToken);
  }

  static Map getUserHeader() {
    var header = {
      "Authorization": "Bearer " + Prefs.getString("userToken"),
      "Content-Type": "application/json; charset=utf-8"
    };
    return header;
  }

  static Future<List> getSheetTokens(
      String sheetToken, String sheetTitle) async {
    var url =
        "https://open.feishu.cn/open-apis/sheets/v2/spreadsheets/$sheetToken/metainfo";
    Map resp = await Http.get(url, null, getUserHeader());
    String token;
    for (var item in resp["sheets"]) {
      if (item["title"] == sheetTitle) {
        token = item['blockInfo']['blockToken'];
        break;
      }
    }
    if (token == null) {
      print("error" + token);
      return [];
    } else {
      List tokens = [];
      var strs = token.split("_");
      tokens.add(strs.first);
      tokens.add(strs[1]);
      return tokens;
    }
  }
}

// 跳转浏览器
void schemeToCode() {
  // 抓包，在 chrome 里输入 url，授权通过，取 code 再赋值到上面
  var url =
      "https://open.feishu.cn/open-apis/authen/v1/index?redirect_uri=https://www.baidu.com/&app_id=cli_a02670ae80f9900e";
  launchUrl(url);
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("无法跳转的 url:" + url);
  }
}



// def get_tenant_header() -> str:
//     tenant_token = get_tenant_token()
//     header = {"Authorization": "Bearer " + tenant_token,
//               "Content-Type": "application/json; charset=utf-8"}
//     return header
