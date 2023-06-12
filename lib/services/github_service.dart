import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_search_app/models/repository.dart';
import 'package:flutter/foundation.dart';

class GithubService {
  Future<List<Repository>> searchRepositories(String keyword) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/search/repositories?q=$keyword'),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<dynamic> items = json['items'];
      return items.map((item) => Repository.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
//ChangeNotifierを継承し、GitHubのリポジトリ検索を行うメソッドとその結果を保持するリスト
class SearchProvider extends ChangeNotifier {
  final GithubService _githubService = GithubService();
  List<Repository> _repositories = [];

  List<Repository> get repositories => _repositories;

  search(String keyword) async {
    _repositories = await _githubService.searchRepositories(keyword);
    notifyListeners();
  }
}