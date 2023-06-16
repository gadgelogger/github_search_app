import 'package:flutter/material.dart';
import 'package:github_search_app/models/repository.dart';

class DetailsScreen extends StatelessWidget {
  final Repository repository;

  const DetailsScreen({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(repository.ownerIconUrl),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.code),
                title: Text('Language'),
                subtitle: Text(repository.language),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text('Stars'),
                subtitle: Text('${repository.stars}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.visibility),
                title: Text('Watchers'),
                subtitle: Text('${repository.watchers}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.call_split),
                title: Text('Forks'),
                subtitle: Text('${repository.forks}'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.warning),
                title: Text('Issues'),
                subtitle: Text('${repository.issues}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
