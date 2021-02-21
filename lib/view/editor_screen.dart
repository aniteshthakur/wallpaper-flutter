import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController changeController;
  Animation changeAnimation;

  Animation animation;
  Container yum() {
    for (var obj in images) {
      print(obj);
      return Container();
    }
  }

  List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    changeController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 30),
        lowerBound: 0,
        upperBound: images.length.toDouble());
    changeAnimation =
        CurvedAnimation(parent: changeController, curve: Curves.fastOutSlowIn);
    changeController.forward();

    Timer(Duration(seconds: 4), () => controller.reverse(from: 1));
    changeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        changeController.reverse(from: images.length.toDouble());
      } else if (status == AnimationStatus.dismissed) {
        changeController.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
      // print(animation.value);
    });
    changeController.addListener(() {
      setState(() {});
      print(changeAnimation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          images[changeController.value.toInt()],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
