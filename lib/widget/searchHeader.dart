import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/view/search_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

TextEditingController searchController = new TextEditingController();
String text;

class NetworkingPageHeader extends SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        shrinkOffset == 300
            ? Container(
                color: Colors.grey[900].withOpacity(0.6),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'images/new1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      left: 120,
                      right: 16,
                      bottom: 115,
                      child: Row(
                        children: [
                          Text(
                            'E',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' N',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' C',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' A',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' N',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' T',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            height: 30,
                            width: 30,
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
                          ),
                        ],
                      )),
                  // Positioned(
                  //   left: 300,
                  //   right: 16,
                  //   bottom: 90,
                  //   child: Container(
                  //     height: 80,
                  //     width: 80,
                  //     margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                  //     child: Image.asset(
                  //       'images/logo.png',
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    right: 310,
                    bottom: 90,
                    child: Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                      child: Image.asset(
                        'images/logo2.png',
                      ),
                    ),
                  ),
                  // Text(
                  //   'Sattva - Rajas - Tamas',
                  //   style: GoogleFonts.pacifico(
                  //     textStyle: TextStyle(
                  //         color: Colors.white,
                  //         letterSpacing: .5,
                  //         fontSize: 19),
                  //   ),

                  // Image.network(
                  //   "https://images.pexels.com/photos/5847447/pexels-photo-5847447.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                  //   fit: BoxFit.cover,
                  // ),
                  Container(
                    color: Color(0xff191919)
                        .withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ],
              ),

        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.transparent, Colors.black54],
        //       stops: [0.5, 1.0],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       tileMode: TileMode.repeated,
        //     ),
        //   ),
        // ),
        Positioned(
          left: 16.0,
          right: 16.0,
          // bottom: 20,
          bottom: searchOpacity(shrinkOffset),
          // bottom: shrinkOffset > 140 ? 5.0 : 20.0,

          child: SearchBar(),

          // Text(
          //   'Lorem ipsum',
          //   style: TextStyle(
          //     fontSize: 32.0,
          //     color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
          //   ),
          // ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    // return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    double c = max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
    if (c > 0.8) {
      return 0.8;
    }

    return c;
  }

  double searchOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0

    return 20.0 - max(0.0, shrinkOffset) / 19;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    // return 20.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

// @override
// FloatingHeaderSnapConfiguration get snapConfiguration => null;
//
// @override
// // TODO: implement showOnScreenConfiguration
// PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
//     throw UnimplementedError();
//
// @override
// // TODO: implement stretchConfiguration
// OverScrollHeaderStretchConfiguration get stretchConfiguration =>
//     throw UnimplementedError();
//
// @override
// // TODO: implement vsync
// TickerProvider get vsync => throw UnimplementedError();
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff8A8C8B), Colors.grey[700]],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.only(left: 24, right: 24, top: 20),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: "search wallpapers", border: InputBorder.none),
          )),
          InkWell(
              onTap: () {
                // getSearchWallpaper(searchController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchView(
                              search: searchController.text,
                            )));
              },
              child: Container(child: Icon(Icons.search)))
        ],
      ),
    );
  }
}
