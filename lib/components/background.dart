import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/top.png",
    this.bottomImage = "assets/images/bottam.jpg",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 250,
              ),
            ),
            Positioned(
               bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 250),
             ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
