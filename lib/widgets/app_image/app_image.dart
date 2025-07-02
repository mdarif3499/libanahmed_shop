import 'dart:io';

import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:flutter/material.dart';

// Enum to define image shapes
enum ImageShape { rectangle, rounded, circle }

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.color,
    this.fit = BoxFit.fill,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.iconColor,
    this.shape = ImageShape.rectangle, // Default shape
    this.borderRadius = 8.0, // Default border radius for rounded shape
  });

  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? color;
  final Color? iconColor;
  final ImageShape shape; // New shape parameter
  final double borderRadius; // Border radius for rounded shape

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildImage(),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Widget _buildImage() {
    Widget imageWidget;

    if (filePath != null) {
      imageWidget = Image.file(
        File(filePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          errorLog("Error loading file image:", error);
          return _buildPlaceholder();
        },
      );
    } else if (url != null) {
      if (url!.toLowerCase().contains("null")) {
        return _buildPlaceholder();
      }
      imageWidget = NetworkImageWithRetry(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (path != null) {
      imageWidget = Image.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        color: iconColor,
        errorBuilder: (context, error, stackTrace) {
          errorLog("Error loading asset image:", error);
          return _buildPlaceholder();
        },
      );
    } else {
      return _buildPlaceholder();
    }

    // Apply shape clipping
    return _applyShape(imageWidget);
  }

  Widget _applyShape(Widget child) {
    switch (shape) {
      case ImageShape.circle:
        return ClipOval(
          child: child,
        );
      case ImageShape.rounded:
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        );
      case ImageShape.rectangle:
        return child;
    }
  }

  Widget _buildPlaceholder() {
    return _applyShape(
      Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}

class NetworkImageWithRetry extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const NetworkImageWithRetry({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
  });

  @override
  State createState() => _NetworkImageWithRetryState();
}

class _NetworkImageWithRetryState extends State<NetworkImageWithRetry> {
  int _retryCount = 0;
  final int _maxRetries = 3;
  String? _image;

  @override
  void initState() {
    super.initState();
    _setImage();
  }

  void _setImage() {
    try {
      final uri = Uri.tryParse(widget.imageUrl);
      if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
        _image = widget.imageUrl;
      } else {
        _image = "${ApiUrls.instance.imageBaseUrl}${widget.imageUrl}";
      }
    } catch (e) {
      _image = widget.imageUrl;
      errorLog("Error setting image:", e);
    }
  }

  void _retry() {
    if (_retryCount < _maxRetries) {
      setState(() {
        _retryCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = CustomHttpClient();
    return FadeInImage(
      placeholder: AssetImage(AppAssertImage.instance.strawberry),
      image: NetworkImage(_image ?? ""),
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      imageErrorBuilder: (context, error, stackTrace) {
        errorLog("Error loading network image:", stackTrace);
        return GestureDetector(
          onTap: _retry,
          child: Container(
            width: widget.width,
            height: widget.height,
            color: AppColors.instance.grey300,
            child: const Center(
              child: Icon(Icons.refresh, color: Colors.white),
            ),
          ),
        );
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
    );
  }
}

class CustomHttpClient extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
