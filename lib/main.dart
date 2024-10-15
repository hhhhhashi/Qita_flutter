import 'package:flutter/material.dart';
import 'package:banana/screens/search_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // packageをインポート

Future<void> main() async {// main関数をFutureに変更
  await dotenv.load(fileName: '.env'); // .envファイルを読み込み
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //今回のアプリの出発点
    return MaterialApp(
      title: 'Qiita Search',  // titleを追加

      //レイアウトを定義
      theme: ThemeData( 
        primarySwatch: Colors.green,
        fontFamily: 'Hiragino Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
      ),

      //最初にSearchScreenを指定して表示させる
      home: const SearchScreen(),

    );
  }
}
