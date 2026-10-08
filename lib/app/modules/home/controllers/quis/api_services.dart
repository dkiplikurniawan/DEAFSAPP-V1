import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

var link = "https://opentdb.com/api.php?amount=20";

getQuiz() async {
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body.toString());
    // ignore: avoid_print
    print("data is loaded");
    return data;
  }
}
