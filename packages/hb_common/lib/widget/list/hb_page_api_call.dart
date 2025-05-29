import 'package:flutter/material.dart';

class HbPageApiCall<T> {
  bool hasMore = true;
  int page = 1;
  final int pageSize = 20;
  List<T> items = [];
  final Future<HbPageModel> Function(Map<String, dynamic>) _apiCall;

  static String pageStr = 'page';
  static String pageSizeStr = 'pageSize';

  /// 设置全局字段名（只设置一次）
  static void setUp({required String pageKey, required String pageSizeKey}) {
    pageStr = pageKey;
    pageSizeStr = pageSizeKey;
  }

  HbPageApiCall(this._apiCall);

  Future<void> loadMore({Map<String, dynamic>? params}) async {
    try {
      params ??= {};
      params.addAll({pageStr: page, pageSizeStr: pageSize});
      HbPageModel res = await _apiCall(params);
      if (page == 1) {
        items = res.items as List<T>;
      } else {
        items.addAll(res.items as List<T>);
      }
      hasMore = res.items.length == res.pageSize;
      if (hasMore) {
        page++;
      }
    } catch (e) {
      debugPrint(e.toString());
      hasMore = false;
    } finally {}
  }

  void refresh() {
    items.clear();
    page = 1;
    hasMore = true;
  }
}

abstract class HbPageModel<T> {
  List<T> get items;
  int get page;
  int get pageSize;
  int get total;
}
