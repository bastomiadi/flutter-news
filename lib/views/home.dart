import 'package:belajar/components/blog.dart';
import 'package:belajar/components/category.dart';
import 'package:belajar/models/blog/article_model.dart';
import 'package:flutter/material.dart';
import 'package:belajar/models/category/category.dart';
import 'package:belajar/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService client = ApiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Flutter", style: TextStyle(
              color: Colors.brown
            ),
            ),
            Text("News", style: TextStyle(
              color: Colors.blue
            ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                //categories
                SizedBox(
                  height: 70,
                  child: FutureBuilder<List<Category>>(
                      future: client.getCategory(),
                      builder: (context, snapshot){
                        if (snapshot.hasData) {
                          List<Category> data = snapshot.data as List<
                              Category>;
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: ScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  imageUrl: data[index].url,
                                  categoryName: data[index].title,
                                );
                              }
                          );
                        }
                        else if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return const Text('error');
                        }
                        return const CircularProgressIndicator();
                      }
                  ),
                ),

                //blog
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: FutureBuilder<List<Articles>>(
                      future: client.getArticle(),
                      builder: (context, snapshot){
                        if (snapshot.hasData) {
                          List<Articles> data = snapshot.data as List<Articles>;
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return NewsTile(
                                  imgUrl: data[index].urlToImage,
                                  title: data[index].title,
                                  description: data[index].description,
                                  content: data[index].content,
                                  posturl: data[index].url,
                                );
                              });
                        }
                        else if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          //return const Text('error');
                          return Text(snapshot.error.toString());
                        }
                        return const CircularProgressIndicator();
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


