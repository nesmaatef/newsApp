import 'dart:convert';

import 'package:newsapp/models/articalmodel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticalModel> news = [];

  Future<void> getnews() async {
    var url = Uri.parse('https://newsapi.org/v2/top-headlines?'
        'country=in&apiKey=89e7ffb9cdb34036a0870ec9fd5755be');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticalModel articalmodel = ArticalModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urltoimage: element["urlToImage"],
              content: element["context"]);
          news.add(articalmodel);
        }
      });
    }
  }
}

class CategoryNewsclass {
  List<ArticalModel> news = [];

  Future<void> getnews(String category) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=89e7ffb9cdb34036a0870ec9fd5755be');

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticalModel articalmodel = ArticalModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urltoimage: element["urlToImage"],
              content: element["context"]);
          news.add(articalmodel);
        }
      });
    }
  }
}
