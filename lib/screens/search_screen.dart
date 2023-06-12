import 'package:flutter/material.dart';
import 'package:github_search_app/providers/search_provider.dart';
import 'package:github_search_app/screens/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () => _controller.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
              onSubmitted: (value) {
                context.read<SearchProvider>().search(value);
              },
            ),
          ),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  title: Container(
                    color: Colors.grey,
                    height: 10.0,
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
