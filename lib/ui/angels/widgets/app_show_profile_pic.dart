import 'package:flutter/material.dart';
import 'package:talkangels/ui/angels/constant/app_assets.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';

class AppShowProfilePic extends StatelessWidget {
  final VoidCallback onTap;
  final Color? color;
  final double? radius;
  final bool? borderShow;
  final String image;

  const AppShowProfilePic({
    super.key,
    required this.onTap,
    this.color,
    this.radius,
    this.borderShow = true,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: radius ?? w * 0.14,
        width: radius ?? w * 0.14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: borderShow == true
              ? Border.all(
                  color: color ?? whiteColor,
                  width: 0.5,
                )
              : Border.all(color: Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.all(radius != null ? radius! / 16 : w * 0.008),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: assetsImage2(image),
                  fit: BoxFit.fill,
                )),
          ),
        ),
      ),
    );
  }
}
