import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hb_common/app/index.dart';
import 'package:hb_common/utils/hb_cache.dart';

enum IconType { netSvg, localSvg, assetSvg, netImg, localImg }

class HbIcon extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? color; // 仅限svg
  final String? icon;
  final Widget? defaultIcon; // 加载中，默认是loading
  final Widget? errorIcon; // 错误时，默认是loading
  final BoxFit? fit;
  final GestureTapCallback? onTap;
  final bool rounded;

  const HbIcon({
    super.key,
    this.width,
    this.height,
    this.color,
    this.defaultIcon,
    this.errorIcon,
    this.icon,
    this.fit,
    this.onTap,
    this.rounded = false,
  });

  @override
  State<HbIcon> createState() => _HbIconState();
}

class _HbIconState extends State<HbIcon> {
  final HbCache _cacheFileUtilImage = HbCache();
  IconType _iconType = IconType.assetSvg;
  String _iconCachePath = '';
  late final Widget? _errorIcon;
  late final Widget _defaultIcon;

  @override
  void initState() {
    super.initState();
    _iconCachePath = widget.icon ?? '';
    initDefaultIcon();
    initType();
    getLocalIcon();
  }

  initDefaultIcon() {
    _errorIcon = widget.errorIcon;
    _defaultIcon =
        widget.defaultIcon ??
        Container(
          alignment: Alignment.center,
          width: widget.width ?? 16.w,
          height: widget.width ?? 16.w,
          decoration: HbStyle.toBoxR8(color: HbColor.bgGrey),
        );
  }

  // 分类图片
  initType() {
    if (_iconCachePath.startsWith("http") && _iconCachePath.endsWith(".svg")) {
      _iconType = IconType.netSvg;
    } else if (_iconCachePath.startsWith("http")) {
      _iconType = IconType.netImg;
    } else if (_iconCachePath.endsWith(".png") ||
        _iconCachePath.endsWith(".jpg") ||
        _iconCachePath.endsWith(".webp") ||
        _iconCachePath.endsWith(".jpeg") ||
        _iconCachePath.endsWith(".gif")) {
      _iconType = IconType.localImg;
    } else if (_iconCachePath.startsWith("assets")) {
      _iconType = IconType.assetSvg;
    } else {
      _iconType = IconType.assetSvg;
    }
  }

  // 本地图片路径
  getLocalIcon() async {
    if (_iconType != IconType.netImg && _iconType != IconType.netSvg) {
      _iconCachePath = widget.icon ?? '';
    } else {
      _iconCachePath = await _cacheFileUtilImage.getFile(_iconCachePath);
      if (_iconType == IconType.netSvg) _iconType = IconType.localSvg;
      if (_iconType == IconType.netImg) _iconType = IconType.localImg;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: widget.rounded ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: GestureDetector(onTap: widget.onTap, child: _buildIcon()),
    );
  }

  Widget _buildIcon() {
    if (_iconCachePath == '') return _defaultIcon;
    if (_iconCachePath == '-') return _defaultIcon;
    if (_iconCachePath == 'null') return _defaultIcon;
    switch (_iconType) {
      case IconType.netSvg:
        return SvgPicture.network(
          _iconCachePath,
          width: widget.width,
          height: widget.height,
          colorFilter:
              widget.color != null
                  ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                  : null,
          placeholderBuilder: (context) {
            return _defaultIcon;
          },
        );
      case IconType.netImg:
        return Image.network(
          _iconCachePath,
          width: widget.width,
          height: widget.height,
          fit: widget.fit ?? BoxFit.cover,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            } else {
              return _defaultIcon;
            }
          },
          errorBuilder: (context, _, __) {
            return _errorIcon ?? _defaultIcon;
          },
        );
      case IconType.localImg:
        return Image.file(
          File(_iconCachePath),
          width: widget.width,
          height: widget.height,
          fit: widget.fit ?? BoxFit.cover,
          errorBuilder: (context, _, __) {
            return Image.asset(
              _iconCachePath,
              width: widget.width,
              height: widget.height,
              fit: widget.fit ?? BoxFit.cover,
              errorBuilder: (context, _, __) {
                return _errorIcon ?? _defaultIcon;
              },
            );
          },
        );
      case IconType.localSvg:
        return SvgPicture.file(
          File(_iconCachePath),
          width: widget.width,
          height: widget.height,
          colorFilter:
              widget.color != null
                  ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                  : null,
          placeholderBuilder: (context) {
            return SvgPicture.asset(
              _iconCachePath,
              width: widget.width,
              height: widget.height,
              colorFilter:
                  widget.color != null
                      ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                      : null,
              placeholderBuilder: (context) {
                return _defaultIcon;
              },
            );
          },
        );
      case IconType.assetSvg:
        return SvgPicture.asset(
          _iconCachePath,
          width: widget.width,
          height: widget.height,
          colorFilter:
              widget.color != null
                  ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                  : null,
          placeholderBuilder: (context) {
            return _defaultIcon;
          },
        );
    }
  }
}
