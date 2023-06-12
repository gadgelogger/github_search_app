import 'package:flutter/material.dart';
import 'package:github_search_app/models/repository.dart';

class DetailsScreen extends StatelessWidget {
  final Repository repository;

  DetailsScreen({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Language: ${repository.language}'),
            Text('Stars: ${repository.stars}'),
            Text('Watchers: ${repository.watchers}'),
            Text('Forks: ${repository.forks}'),
            Text('Issues: ${repository.issues}'),
          ],
        ),
      ),
    );
  }
}
