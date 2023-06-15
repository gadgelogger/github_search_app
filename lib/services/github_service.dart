import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_search_app/models/repository.dart';
import 'package:flutter/foundation.dart';

class GithubService {
  Future<SearchResult> searchRepositories(String keyword) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/search/repositories?q=$keyword'),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      int totalCount = json['total_count'];
      List<dynamic> items = json['items'];
      List<Repository> repositories = items.map((item) => Repository.fromJson(item)).toList();
      return SearchResult(totalCount: totalCount, items: repositories);
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
//ChangeNotifierを継承し、GitHubのリポジトリ検索を行うメソッドとその結果を保持するリスト
class SearchProvider extends ChangeNotifier {
  final GithubService _githubService = GithubService();
  List<Repository> _repositories = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String _errorMessage = '';
  int _totalCount = 0;

  List<Repository> get repositories => _repositories;
  bool get isLoading => _isLoading;
  bool get hasSearched => _hasSearched;
  String get errorMessage => _errorMessage;
  int get totalCount => _totalCount;

  void clear() {
    _repositories = [];
    _isLoading = false;
    _hasSearched = false;
    _errorMessage = '';
    _totalCount = 0;
    notifyListeners();
  }

  Future<void> search(String keyword) async {
    _isLoading = true;
    _hasSearched = true;
    _errorMessage = '';
    notifyListeners();
    try {
      var result = await _githubService.searchRepositories(keyword);
      _repositories = result.items;
      _totalCount = result.totalCount;
      if (_repositories.isEmpty) {
        _errorMessage = 'リポジトリが見つかりませんでした。';
      }
    } catch (e) {
      _errorMessage = '不正なリクエストが送信されました。';
    }
    _isLoading = false;
    notifyListeners();
  }
}
//検索ワードにヒットしたリポジトリ数を
class SearchResult {
  final int totalCount;
  final List<Repository> items;

  SearchResult({required this.totalCount, required this.items});
}
