import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/data/data.dart';
import 'package:my_app/models/photos_model.dart';
import 'package:my_app/widget/mainContent.dart';
import 'package:my_app/widget/searchContent.dart';
import 'package:my_app/widget/silverSearch.dart';
import 'package:my_app/widget/widget.dart';
import 'package:my_app/widget/searchHeader.dart';

class SearchView extends StatelessWidget {
  final String search;

  SearchView({@required this.search});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff191919),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SilverSearch(
                minExtent: 80.0,
                maxExtent: 120.0,
              ),
            ),
            SearchContent(search: search)
          ],
        ),
      ),
    );
  }
}
