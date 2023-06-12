import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_search_app/models/repository.dart';
import 'package:flutter/foundation.dart';
//Githubから取得
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
  GithubService _githubService = GithubService();
  List<Repository> _repositories = [];
  bool _isLoading = false;  // 追加

  List<Repository> get repositories => _repositories;
  bool get isLoading => _isLoading;  // 追加

  search(String keyword) async {
    _isLoading = true;  // 追加
    notifyListeners();

    _repositories = await _githubService.searchRepositories(keyword);

    _isLoading = false;  // 追加
    notifyListeners();
  }
}
