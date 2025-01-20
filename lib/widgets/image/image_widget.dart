import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  String? image;
  double? width, height;
  BoxFit? fit;

  ImageWidget({this.image, this.fit, this.height, this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        image.toString(),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final BoxFit? fit;

  const NetworkImageWidget({
    this.imageUrl,
    this.fit,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: fit ?? BoxFit.contain,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
