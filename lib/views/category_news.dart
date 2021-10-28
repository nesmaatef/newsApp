// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/articalmodel.dart';
import 'package:newsapp/models/categoryModel.dart';
import 'package:newsapp/views/artical_view.dart';

class CategoryNews extends StatefulWidget {
  String category;

  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  // List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticalModel> articals = new List<ArticalModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    getcategorynews();
    super.initState();
    // categories = getCategories();
  }

  getcategorynews() async {
    CategoryNewsclass newsclass = CategoryNewsclass();
    await newsclass.getnews(widget.category);
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
        leading: GestureDetector(
          onTap: () {},
          child: (Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
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
                ),
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
