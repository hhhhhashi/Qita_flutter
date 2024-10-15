import 'package:flutter/material.dart';
import 'package:banana/models/article.dart';
import 'package:intl/intl.dart';
import 'package:banana/screens/article_screen.dart';


class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  ///記事の情報を保持する
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(

      //余白の設定
      padding: const EdgeInsets.symmetric(
         vertical: 12,
         horizontal: 16,
      ),

      child: GestureDetector(

        //画面遷移
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => ArticleScreen(article: article)),
            ),
          );
        },

        //検索結果一覧のコンテンツの設定
        child: Container(

          //内側の余白を指定
          padding: const EdgeInsets.symmetric( 
            horizontal: 20,
            vertical: 16,
          ),

          //スタイルの設定
          decoration: const BoxDecoration(
            color: Color(0xFF55C500), 
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),

          //コンテンツに表示される項目の設定
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // 投稿日のスタイル設定
              Text(
                DateFormat('yyyy/MM/dd').format(article.createdAt),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),

              // タイトルのスタイル設定
              Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // タグのスタイル設定
              Text(
                '#${article.tags.join(' #')}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              

              Row(
                //ハートアイコンいいね数と投稿者のアイコン投稿者名の間隔を指定
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //ハートアイコンいいね数と投稿者のアイコン投稿者名の縦方向の指定
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [

                  // ハートアイコンといいね数
                  Column(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      Text(
                        article.likesCount.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // 投稿者のアイコンと投稿者名の設定
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      //投稿者アイコンの設定
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(article.user.profileImageUrl),
                      ),

                      const SizedBox(height: 4),
                      
                      //投稿者名の設定
                      Text(
                        article.user.id,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],

                  ),
                ],
              ),
            ],
          ),//コンテンツに表示される項目の設定終了

        ),
      )
    );
  }
}