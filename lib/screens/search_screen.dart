import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app/services/github_service.dart';
import 'package:github_search_app/screens/details_screen.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  Widget _buildShimmer(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        highlightColor: isDarkMode ? Colors.grey[600]! : Colors.grey[200]!,
        child: ListTile(
          leading: ClipOval(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.white,
            ),
          ),
          title: SizedBox(
            height: 20.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Icon(Icons.star_border, color: Colors.white),
                  SizedBox(
                    width: 50.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 10.0,
                    height: 10.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5.0),
                  SizedBox(
                    width: 100.0,
                    height: 10.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) {
                        context.read<SearchProvider>().search(value);
                      },
                      decoration: InputDecoration(
                        hintText: '検索',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _controller.clear();
                            context.read<SearchProvider>().clear();
                          },
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[300]
                                : Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Consumer<SearchProvider>(
              builder: (_, provider, __) {
                if (provider.hasSearched &&
                    !provider.isLoading &&
                    provider.errorMessage.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '${provider.totalCount}件',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return _buildShimmer(context);
                  } else if (provider.errorMessage.isNotEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 200,
                            height: 200,
                            child: Image(
                              image: AssetImage('assets/error.gif'),
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          provider.errorMessage,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ));
                  } else if (provider.repositories.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 200,
                            height: 200,
                            child: Image(
                              image: AssetImage('assets/search.gif'),
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'リポジトリを検索できます',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ));
                  } else {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.pixels >=
                                notification.metrics.maxScrollExtent - 200) {
                          provider.fetchMore(_controller.text);
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: provider.repositories.length +
                            (provider.isLoadingMore ? 1 : 0),
                        itemBuilder: (_, index) {
                          if (index < provider.repositories.length) {
                            final repository = provider.repositories[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: ClipOval(
                                    child: Image.network(
                                      repository.ownerIconUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    repository.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${repository.description}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star_border),
                                          Text('${repository.stars}'),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text('${repository.language}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetailsScreen(repository: repository),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.black12,
                                ),
                              ],
                            );
                          } else if (provider.isLoadingMore) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
