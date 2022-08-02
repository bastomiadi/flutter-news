import 'dart:convert';
import 'package:belajar/models/blog/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:belajar/models/category/category.dart';

class ApiService {

    Future<List<Articles>> getArticle() async {
      final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=id&apiKey=4bb0db3cbbe449019ea08e39de70ecf8'));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Articles> articles = body.map((dynamic item) => Articles.fromJson(item)).toList();
        return articles;
      } else {
        throw Exception('Failed to load article');
      }
    }

  Future<List<Category>> getCategory() async {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Category>((json) => Category.fromMap(json)).toList();
      } else {
        throw Exception('Failed to load category');
      }
    }
}