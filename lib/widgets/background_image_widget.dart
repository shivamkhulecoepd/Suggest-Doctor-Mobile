import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A widget that displays a background image with color overlay
class BackgroundImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? child;
  final Color overlayColor;
  final double overlayOpacity;
  final BoxFit fit;

  const BackgroundImageWidget({
    super.key,
    required this.imageUrl,
    this.child,
    this.overlayColor = Colors.black,
    this.overlayOpacity = 0.3,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            placeholder: (context, url) => Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
        ),
        // Color overlay
        Positioned.fill(
          child: Container(
            color: overlayColor.withOpacity(overlayOpacity),
          ),
        ),
        // Child content
        if (child != null) child!
      ],
    );
  }
}