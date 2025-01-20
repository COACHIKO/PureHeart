import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
 
class SvgImageWidget extends StatelessWidget {
  final String? image;
  final double? width, height;
  final BoxFit? fit;
  final Color? color;

  const SvgImageWidget({
    this.image,
    this.height,
    this.width,
    this.fit,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        image ?? '',
        fit: fit ?? BoxFit.contain,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
