import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app/services/github_service.dart';
import 'package:github_search_app/screens/details_screen.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          title: Container(
            color: Colors.white,
            height: 20.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      context.read<SearchProvider>().search(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _controller.clear();
                    context.read<SearchProvider>().clear();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (_, provider, __) {
                if (provider.isLoading) {
                  return _buildShimmer();
                } else if (provider.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(provider.errorMessage),
                  );
                } else if (provider.repositories.isEmpty) {
                  return Center(
                    child: Text('リポジトリを検索できます'),
                  );
                } else {
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
