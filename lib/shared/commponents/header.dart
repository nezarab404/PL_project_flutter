// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final double height;
  final Color color;

  const Header({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: HeaderArcClipper(),
      child: Container(
        color: color,
        height: height,
        width: double.infinity,
      ),
    );
  }
}

class HeaderArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: const Radius.elliptical(35, 15),
    );
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
