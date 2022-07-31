import 'package:belajar/views/article_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  dynamic imgUrl, title, description, content, posturl;

  NewsTile({Key? key, this.imgUrl, this.description, this.title, this.content, @required this.posturl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: posturl,
            )
        )
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(imageUrl: imgUrl)
            ),
            const SizedBox(height: 8,),
            Text(title, style: const TextStyle(
              fontSize: 17,
              color: Colors.black87,
              fontWeight: FontWeight.w600
            ),),
            const SizedBox(height: 8,),
            Text(description, style: const TextStyle(
              color: Colors.grey
            ),)
          ],
        ),
      ),
    );
  }
}