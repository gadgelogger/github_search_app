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
      ),
      body: ListView(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(repository.ownerIconUrl),
              ),
              SizedBox(height: 10),
              Text(
                repository.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Language'),
            subtitle: Text('${repository.language}'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Stars'),
            subtitle: Text('${repository.stars}'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Watchers'),
            subtitle: Text('${repository.watchers}'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.call_split),
            title: Text('Forks'),
            subtitle: Text('${repository.forks}'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.warning),
            title: Text('Issues'),
            subtitle: Text('${repository.issues}'),
          ),
        ],
      ),
    );
  }
}
