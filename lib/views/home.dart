// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/articalmodel.dart';
import 'package:newsapp/models/categoryModel.dart';
import 'package:newsapp/views/artical_view.dart';
import 'package:newsapp/views/category_news.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticalModel> articals = new List<ArticalModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getnews();
  }

  getnews() async {
    News newsclass = News();
    await newsclass.getnews();
    articals = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            Text(
              'News',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        height: 70.0,
                        child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageurl: categories[index].image,
                                categoryName: categories[index].name,
                              );
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articals.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articals[index].urltoimage,
                                title: articals[index].title,
                                desc: articals[index].description,
                                url: articals[index].url,
                              );
                            }),
                      )
                    ],
                  )),
            ),
    );
  }
}
// @dart=2.9

class CategoryTile extends StatelessWidget {
  // const CategoryTile({Key key}) : super(key: key);
  String imageurl, categoryName;

  CategoryTile({this.imageurl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Sending hi"),
        ));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryName.toString().toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageurl,
                width: 120.0,
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  // const BlogTile({Key key}) : super(key: key);

  BlogTile({this.imageUrl, this.title, this.desc, this.url});

  String imageUrl, title, desc, url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Artical_view(blogurl: url)));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 17.0, color: Colors.black87),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(desc, style: TextStyle(color: Colors.black38))
          ],
        ),
      ),
    );
  }
}
