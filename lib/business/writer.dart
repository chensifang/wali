// 读工单
import 'package:wali/base/model.dart';
import 'package:wali/feishu/api.dart';
import 'package:wali/feishu/auth.dart';
import 'package:wali/share.dart';

class Writer {
  static write() async {
    // 读工单
    List lsi = await readWorkTable();
    List workTasks = handelData0(lsi);

    // 读反馈表
    var tokens = await Auth.getSheetTokens(
        "shtcnQ4CX1OeDvdBdabQuzMfr3f", Prefs.getString("sheet"));
    var items = await Api.readManyTable(tokens);
    print(items);

    // 过滤重复的
    List links = getLink(items);
    var delLis = [];
    for (var t in workTasks) {
      Task t1 = t;
      if (links.contains(t1.link)) {
        delLis.add(t1);
      }
    }
    for (var t in delLis) {
      workTasks.remove(t);
    }

    // 转换为上传的数据结构
    List records = handelData1(workTasks);

    // 上传
    Api.writeManyTable(records, tokens);
  }

  // 读工单
  static Future<List> readWorkTable() async {
    List lis =
        await Api.readNormalTable("shtcnbrB3iIEb27RVH5ZK8MydQe", "PpL1eA");
    return lis;
  }

  // 过滤出会员的
  static List handelData0(List rows) {
    int taskIndex;
    int assginerIndex;
    int busIndex;
    List titles = rows[0];
    for (var i = 0; i < titles.length; i++) {
      var title = titles[i];
      if (title == "Task Id") {
        taskIndex = i;
      } else if (title == "Task 归属人") {
        assginerIndex = i;
      } else if (title == "业务模式（新）") {
        busIndex = i;
      }
    }
    rows.remove(rows.first);
    var tasks = [];
    for (var row in rows) {
      if (row[busIndex] == "会员") {
        var task = Task();
        task.assigner = row[assginerIndex];
        var dic = row[taskIndex][0];
        task.link = dic["text"];
        var strs = task.link.split("/");
        task.text = strs[strs.length - 1];
        tasks.add(task);
      }
    }
    print("工单表新增: " + tasks.length.toString());
    return tasks;
  }

  // 获取 links
  static List getLink(List items) {
    var links = [];
    if (items == null) {
      return links;
    }
    for (Map item in items) {
      if (item.containsKey("fields") &&
          (item["fields"] as Map).containsKey("Task")) {
        var task = item["fields"]["Task"];
        var link = task["link"];
        links.add(link);
      }
    }
    return links;
  }

  // 转换为上传需要的数据
  static List handelData1(tasks) {
    var records = [];
    for (Task task in tasks) {
      var dic = Map();
      dic["Task"] = {"text": task.text, "link": task.link};
      dic["负责人"] = [
        {"id": task.assigner}
      ];
      dic["状态"] = "未解决";
      dic["整理时间"] = DateTime.now().millisecondsSinceEpoch;
      records.add({"fields": dic});
    }
    return records;
  }
  //
}
