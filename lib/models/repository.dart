class Repository {
  final String name;
  final String ownerIconUrl;
  final String description;  // 追加
  final String language;
  final int stars;
  final int watchers;
  final int forks;
  final int issues;

  Repository({
    required this.name,
    required this.ownerIconUrl,
    required this.description,  // 追加
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.issues,
  });

  // データのパース用
  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      ownerIconUrl: json['owner']['avatar_url'],
      description: json['description'] ?? "N/A",  // 追加
      language: json['language'] ?? "N/A",
      stars: json['stargazers_count'],
      watchers: json['watchers_count'],
      forks: json['forks_count'],
      issues: json['open_issues_count'],
    );
  }
}
