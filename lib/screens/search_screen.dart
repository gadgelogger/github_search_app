import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app/screens/details_screen.dart';
import 'package:github_search_app/services/github_service.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
              onSubmitted: (value) {
                context.read<SearchProvider>().search(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (_, provider, __) => ListView.builder(
                itemCount: provider.repositories.length,
                itemBuilder: (_, index) {
                  final repository = provider.repositories[index];
                  return ListTile(
                    title: Text(repository.name),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(repository: repository),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
