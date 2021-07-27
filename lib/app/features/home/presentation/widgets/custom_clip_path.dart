import 'package:flutter/material.dart';

class AppBarCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint = Offset(size.width / 4, size.height);
    var endPoint = Offset(size.width / 2, size.height - 20);

    var controlPoint1 = Offset(size.width * (3 / 4), size.height - 40);
    var endPoint1 = Offset(size.width, size.height - 20);

    Path path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint1.dx,
        controlPoint1.dy,
        endPoint1.dx,
        endPoint1.dy,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
