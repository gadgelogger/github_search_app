import 'package:intl/intl.dart';

class Repository {
  final String name;
  final String ownerIconUrl;
  final String description;
  final String language;
  final int stars;
  final int watchers;
  final int forks;
  final int issues;
  final String html_url;
  final String license;  // 追加
  final DateTime createdAt;  // 型をStringからDateTimeに変更
  final DateTime updatedAt;  // 型をStringからDateTimeに変更
  final String ower_name;

  Repository({
    required this.name,
    required this.ownerIconUrl,
    required this.description,
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.issues,
    required this.html_url,
    required this.license,  // 追加
    required this.createdAt,  // 追加
    required this.updatedAt, // 追加
    required this.ower_name
  });

  // データのパース用
  factory Repository.fromJson(Map<String, dynamic> json) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    var createdAt = inputFormat.parse(json['created_at']);
    var updatedAt = inputFormat.parse(json['updated_at']);
    String license = json['license'] != null ? json['license']['name'] : 'N/A';
    String ower_name = json['owner'] != null ? json['owner']['login'] : 'N/A';

    return Repository(
      name: json['name'],
      ownerIconUrl: json['owner']['avatar_url'],
      description: json['description'] ?? "N/A",
      language: json['language'] ?? "N/A",
      stars: json['stargazers_count'],
      watchers: json['watchers_count'],
      forks: json['forks_count'],
      issues: json['open_issues_count'],
      html_url: json['html_url'],
      ower_name: ower_name,
      license: license,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
