import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app/screens/details_screen.dart';
import 'package:github_search_app/services/github_service.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
            Expanded(
            child: TextField(
            controller: _controller,
              onSubmitted: (value) {
                context.read<SearchProvider>().search(value);
              },
              decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey[300],
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _controller.clear(),
                  ),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          ),
        ),
      ),

      IconButton(
        icon: Icon(Icons.sort),
        onPressed: () =>
            context.read<SearchProvider>().search(_controller.text),
      ),
      ],
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
    title: Container(
    width: double.infinity,
    height: 12.0,
    color: Colors.white,
    ),
    ),
    ),
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
    )
    ,
    );
  }
}
