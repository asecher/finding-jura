/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsCharactersGen {
  const $AssetsCharactersGen();

  /// Directory path: assets/characters/player
  $AssetsCharactersPlayerGen get player => const $AssetsCharactersPlayerGen();
}

class $AssetsCharactersPlayerGen {
  const $AssetsCharactersPlayerGen();

  /// Directory path: assets/characters/player/poses
  $AssetsCharactersPlayerPosesGen get poses =>
      const $AssetsCharactersPlayerPosesGen();
}

class $AssetsCharactersPlayerPosesGen {
  const $AssetsCharactersPlayerPosesGen();

  /// File path: assets/characters/player/poses/idle.png
  AssetGenImage get idle =>
      const AssetGenImage('assets/characters/player/poses/idle.png');

  /// File path: assets/characters/player/poses/run1.png
  AssetGenImage get run1 =>
      const AssetGenImage('assets/characters/player/poses/run1.png');

  /// File path: assets/characters/player/poses/run2.png
  AssetGenImage get run2 =>
      const AssetGenImage('assets/characters/player/poses/run2.png');

  /// File path: assets/characters/player/poses/run3.png
  AssetGenImage get run3 =>
      const AssetGenImage('assets/characters/player/poses/run3.png');

  /// File path: assets/characters/player/poses/run4.png
  AssetGenImage get run4 =>
      const AssetGenImage('assets/characters/player/poses/run4.png');

  /// File path: assets/characters/player/poses/run5.png
  AssetGenImage get run5 =>
      const AssetGenImage('assets/characters/player/poses/run5.png');

  /// File path: assets/characters/player/poses/run6.png
  AssetGenImage get run6 =>
      const AssetGenImage('assets/characters/player/poses/run6.png');

  /// List of all assets
  List<AssetGenImage> get values => [idle, run1, run2, run3, run4, run5, run6];
}

class Assets {
  Assets._();

  static const $AssetsCharactersGen characters = $AssetsCharactersGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
