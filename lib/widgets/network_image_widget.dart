import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A responsive network image widget with placeholder and error handling
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color? color;
  final bool isCircle;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width = 50,
    this.height = 50,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircle ? BorderRadius.circular(width / 2) : borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: isCircle ? BorderRadius.circular(width / 2) : borderRadius,
          ),
          child: Center(
            child: Icon(
              Icons.image,
              size: width * 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: isCircle ? BorderRadius.circular(width / 2) : borderRadius,
          ),
          child: Center(
            child: Icon(
              Icons.error_outline,
              size: width * 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}