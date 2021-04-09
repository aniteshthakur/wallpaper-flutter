import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/view/search_view.dart';
import 'package:my_app/widget/mainContent.dart';
import 'package:my_app/widget/searchHeader.dart';
import 'package:my_app/widget/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

import 'data/data.dart';
import 'models/categorie_model.dart';
import 'models/photos_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List();

  int noOfImageToLoad = 30;
  int page = 1;
  List<PhotosModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=$page",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xff191919),
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: NetworkingPageHeader(
                    minExtent: 80.0,
                    maxExtent: 300.0,
                  ),
                ),
                MainContent()
              ],
            ),
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   alignment: Alignment.bottomCenter,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       InkWell(
          //           onTap: () {
          //             //Navigator.pop(context);
          //           },
          //           child: Stack(
          //             children: <Widget>[
          //               Container(
          //                 width: MediaQuery.of(context).size.width / 2.5,
          //                 height: 50,
          //                 decoration: BoxDecoration(
          //                   color: Color(0xff1C1B1B).withOpacity(0.8),
          //                   borderRadius: BorderRadius.circular(40),
          //                 ),
          //               ),
          //               Container(
          //                   width: MediaQuery.of(context).size.width / 2.5,
          //                   height: 50,
          //                   alignment: Alignment.center,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(40),
          //                       gradient: LinearGradient(
          //                           colors: [
          //                             Color(0x36FFFFFF),
          //                             Color(0x0FFFFFFF)
          //                           ],
          //                           begin: FractionalOffset.topLeft,
          //                           end: FractionalOffset.bottomRight)),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: <Widget>[
          //                       Icon(
          //                         Icons.home,
          //                         color: Colors.white,
          //                         size: 30,
          //                       ),
          //                       SizedBox(
          //                         width: 20,
          //                       ),
          //                       Icon(
          //                         Icons.face,
          //                         color: Colors.white,
          //                         size: 30,
          //                       ),
          //                     ],
          //                   )),
          //             ],
          //           )),
          //       SizedBox(
          //         height: 16,
          //       ),
          //       SizedBox(
          //         height: 50,
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, category;

  CategoriesTile({@required this.imgUrls, @required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchView(
                      search: category,
                    )));
      },
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10),
              height: 153,
              width: 355,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  imgUrls,
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            height: 153,
            width: 355,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff1C1B1B).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0x36FFFFFF),
                                    Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight)),
                          child: Text(
                            category,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
