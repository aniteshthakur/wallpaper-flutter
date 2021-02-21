import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/view/search_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

TextEditingController searchController = new TextEditingController();
String text;

class SilverSearch extends SliverPersistentHeaderDelegate {
  SilverSearch({
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
        shrinkOffset == 120
            ? Container(
                color: Colors.grey[900].withOpacity(0.6),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff191919),
                    ),
                  ),
                  Container(
                    color: Color(0xff191919)
                        .withOpacity(titleOpacity(shrinkOffset)),
                  ),
                ],
              ),
        Positioned(
          left: 16.0,
          right: 16.0,
          // bottom: 20,
          bottom: searchOpacity(shrinkOffset),
          // bottom: shrinkOffset > 140 ? 5.0 : 20.0,

          child: SearchBar(),
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

    return 15.0 - max(0.0, shrinkOffset) / 19;
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
