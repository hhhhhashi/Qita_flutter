import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:banana/models/article.dart';
import 'package:banana/widgets/article_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // 検索結果を格納する変数
  List<Article> articles = []; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //上部バーの設定
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      
      //本文の設定
      body: Column(
        children: [

          // 検索ボックス
          Padding(

            //検索ボックスの余白調整
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),

            //検索フィールドの編集
            child: TextField(

              //スタイルの調整
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
               
              //プレースホルダ(ヒントテキスト)の編集
              decoration: const InputDecoration(
                hintText: '検索ワードを入力してください',
              ),

              //Enterボタン押下後の処理
              onSubmitted: (String value) async {

                // Qiita記事をキーワード検索し10件取得する処理をして、変数に代入する
                final results = await searchQiita(value); 
                // 検索結果を代入
                setState(() => articles = results); 
              },

            ),

          ),

          //検索結果の表示
          //縦方向の制御を行う
          Expanded(
            child: ListView(
              children: articles
                  .map((article) => ArticleContainer(article: article))
                  .toList(),
            ),
          ),

        ],
      ),
    );
  }
}

//Qiita記事をキーワード検索し10件取得する処理
Future<List<Article>> searchQiita(String keyword) async {

  // 1. http通信に必要なデータを準備をする
  //   - 第一引数：BaseURL、第二引数：URL、第三引数：クエリパラメータの設定
  final uri = Uri.https('qiita.com', '/api/v2/items', {
    'query': 'title:$keyword',
    'per_page': '10',
  });

  //   - アクセストークンの取得
  final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

  // 2. アクセストークンを含めてリクエストを送信
  final http.Response res = await http.get(uri, headers: {
    'Authorization': 'Bearer $token',
  });

  // 3. 戻り値をArticleクラスの配列に変換
  // 4. 変換したArticleクラスの配列を返す(returnする)
  if (res.statusCode == 200) {
    // レスポンスをモデルクラスへ変換
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  } else {
    return [];
  }
}