import 'package:flutter/material.dart';
import 'package:github_search_app/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app/services/github_service.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SearchProvider(),
        child: MaterialApp(
          builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
          ),
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.black,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.grey[400],
            ),
            useMaterial3: true,
          ),
          home: SearchScreen(),
        ));
  }
}
