import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/hb_color.dart';
import '../../extensions/index.dart';
import '../../localization/hb_common_localizations.dart';
import '../hb_icon.dart';
import 'hb_page_api_call.dart';

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class HbList<T> extends StatefulWidget {
  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final RefreshCallback? onRefresh; // 下拉刷新回调 与reverse:true时不能同时生效
  final bool? hasMore; // 是否还有数据
  final bool reverse; // 是否反转滚动
  final bool shrinkWrap; // 是否反转滚动
  final double? itemExtent;
  final ScrollController? controller;
  final Widget? skeleton; // 刚刚加载时显示骨架屏
  final Widget? bottomWidget; // 底部widget
  final Widget? noDataWidget; // 底部widget
  final Color? backgroundColor; // 背景色
  final HbPageApiCall<T>? apiCall; // 列表数据请求

  const HbList({
    super.key,
    this.itemCount,
    required this.itemBuilder,
    this.apiCall,
    this.onRefresh,
    this.hasMore,
    this.reverse = false,
    this.shrinkWrap = true,
    this.controller,
    this.itemExtent,
    this.skeleton,
    this.bottomWidget,
    this.noDataWidget,
    this.backgroundColor,
  });

  @override
  State<HbList> createState() => _HbListState();
}

class _HbListState extends State<HbList> {
  late final ScrollController _controller;
  // 是否显示浮动按钮
  final _showFloatingButton = ValueNotifier<bool>(false);
  int get itemCount => widget.itemCount ?? widget.apiCall?.counts ?? 0;

  bool get hasMore =>
      widget.hasMore ?? widget.apiCall?.hasMore ?? false; // 是否还有数据

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    // 监听滚动条位置
    _controller.addListener(() {
      if (_controller.offset > 800) {
        if (!_showFloatingButton.value) {
          _showFloatingButton.value = true;
        }
      } else {
        if (_showFloatingButton.value) {
          _showFloatingButton.value = false;
        }
      }
    });
  }

  // 下拉刷新
  Future<void> _onRefresh() async {
    if (mounted) setState(() {});
    widget.apiCall?.refresh();
    await widget.onRefresh?.call();
    if (mounted) setState(() {});
  }

  // 上拉加载更多
  Future<void> _loadMore() async {
    if (widget.apiCall == null) return;
    await widget.apiCall?.loadMore();
    if (mounted) setState(() {});
  }

  Widget createListWidget() {
    Widget listWidget = Scrollbar(
      controller: _controller,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: widget.shrinkWrap,
        reverse: widget.reverse,
        controller: _controller,
        itemExtent: widget.itemExtent, // 每个块的大小，使拖动滚动条更平滑
        itemCount: itemCount + 1,
        itemBuilder: (context, index) {
          if (index == itemCount) {
            if (hasMore) {
              _loadMore();
              if (itemCount == 0 && widget.skeleton != null) {
                return widget.skeleton;
              }
              return const _BottomLoading();
            } else if (itemCount == 0) {
              return Column(
                children: [
                  widget.noDataWidget ??
                      HbIcon(
                        icon: "packages/hb_common/assets/svg/icon_no_data.svg",
                        width: 94.w,
                      ),
                  HbCommonLocalizations.current.noData.text14w500Grey().pt(8.w),
                ],
              ).pt(0.5.sh - 100.w < 0 ? 0 : 0.5.sh - 100.w);
            } else {
              return widget.bottomWidget ??
                  SafeArea(
                    minimum: const EdgeInsets.only(bottom: 16, top: 16),
                    child: Text(
                      HbCommonLocalizations.current.totalTip(itemCount),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: HbColor.textGrey),
                    ),
                  );
            }
          }
          return widget.itemBuilder(context, index);
        },
      ),
    );
    if (widget.reverse ||
        (widget.onRefresh == null && widget.apiCall == null)) {
      return listWidget;
    } else {
      return RefreshIndicator(onRefresh: _onRefresh, child: listWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: createListWidget(),
      // 置顶按钮
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _showFloatingButton,
        builder: (context, value, _) {
          return Visibility(
            visible: value && !widget.reverse,
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: FloatingActionButton(
                onPressed: _toTop,
                child: const Icon(Icons.keyboard_double_arrow_up),
              ),
            ),
          );
        },
      ),
    );
  }

  void _toTop() {
    // 滚动到顶部
    _controller.animateTo(
      -10,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}

class _BottomLoading extends StatelessWidget {
  const _BottomLoading();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(radius: 7.0),
          const SizedBox(width: 7),
          Text(
            '${HbCommonLocalizations.current.loading}...',
            style: TextStyle(fontSize: 12, color: HbColor.textGrey),
          ),
        ],
      ),
    );
  }
}
