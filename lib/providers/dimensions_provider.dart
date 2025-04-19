import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final dimensionsProvider =
    AsyncNotifierProvider<DimensionsNotifier, DimensionsState>(() {
      return DimensionsNotifier();
    });

class DimensionsState {
  final double height;
  final double width;
  final String platform;

  DimensionsState({
    required this.height,
    required this.width,
    required this.platform,
  });
}

class DimensionsNotifier extends AsyncNotifier<DimensionsState> {
  BuildContext? context;

  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  Future<DimensionsState> build() async {
    final bool isMobile = Platform.isIOS || Platform.isAndroid;
    String platform = isMobile ? 'Mobile' : 'Desktop';

    // Default dimensions based on platform type
    double defaultHeight;
    double defaultWidth;

    if (isMobile) {
      defaultHeight = 800 * 0.8; // 80% of standard mobile height
      defaultWidth = 400 * 0.8; // 80% of standard mobile width
    } else {
      defaultHeight = 900 * 0.8; // 80% of desktop default height
      defaultWidth = 1440 * 0.8; // 80% of desktop default width
    }

    return DimensionsState(
      height: defaultHeight,
      width: defaultWidth,
      platform: platform,
    );
  }

  void updateDimensions(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isMobile = Platform.isIOS || Platform.isAndroid;
    String platform = isMobile ? 'Mobile' : 'Desktop';

    double height;
    double width = mediaQuery.size.width * 0.8; // 80% of screen width

    if (isMobile) {
      height =
          (mediaQuery.size.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom) *
          0.8;
    } else {
      height = mediaQuery.size.height * 0.8;
    }

    state = AsyncData(
      DimensionsState(height: height, width: width, platform: platform),
    );
  }

  double getHeightPercentage(double percentage) {
    return state.value!.height * (percentage / 100);
  }

  double getWidthPercentage(double percentage) {
    return state.value!.width * (percentage / 100);
  }
}
