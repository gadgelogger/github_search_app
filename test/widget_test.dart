import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:github_search_app/services/github_service.dart';

void main() {
  testWidgets('検索フィールド入力とローディングインジケータのチェック', (WidgetTester tester) async {
    // プロバイダーの設定
    final SearchProvider searchProvider = SearchProvider();

    // アプリの構築とフレームのトリガー
    await tester.pumpWidget(
      ChangeNotifierProvider<SearchProvider>.value(
        value: searchProvider,
        child: MaterialApp(
          home: SearchScreen(),
        ),
      ),
    );

    // 検索フィールドを見つける
    expect(find.byType(TextField), findsOneWidget);

    // TextFieldに'flutter'を入力します
    await tester.enterText(find.byType(TextField), 'flutter');

    // キーボード上のキーを押すのをシミュレートします。
    await tester.testTextInput.receiveAction(TextInputAction.done);

    // この操作はテストを5秒間遅らせます。APIのレスポンスを待つためです。
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // _buildShimmerが表示されなくなったことを確認します
    expect(find.byWidgetPredicate((widget) => widget.toString().startsWith('_buildShimmer')), findsNothing);
  });
}
