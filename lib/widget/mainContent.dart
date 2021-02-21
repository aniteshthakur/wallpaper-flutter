import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_app/data/data.dart';
import 'package:my_app/models/categorie_model.dart';
import 'package:my_app/models/photos_model.dart';
import 'package:my_app/widget/widget.dart';

import '../home.dart';

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<CategoryModel> categories = new List();

  int noOfImageToLoad = 80;
  List<PhotosModel> photos = new List();
  int page = 1;

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=$page",
        headers: {"Authorization": apiKEY}).then((value) {
      // print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();

    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: Text(
                "Explore",
                style: TextStyle(
                  //customize depth here
                  color: Colors.grey[50],
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  //customize color here
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    /// Create List Item tile
                    return CategoriesTile(
                      imgUrls: categories[index].imgUrl,
                      category: categories[index].categoryName,
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: Text(
                "New",
                style: TextStyle(
                  //customize depth here
                  color: Colors.grey[50],
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  //customize color here
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            wallPaper(photos, context),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                page = page + 1;
                getTrendingWallpaper();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color(0xff191919),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[900],
                            offset: Offset(4.0, 4.0),
                            blurRadius: 5.0,
                            spreadRadius: 1),
                        BoxShadow(
                            color: Colors.grey[700],
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 5.0,
                            spreadRadius: 1),
                      ]),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
