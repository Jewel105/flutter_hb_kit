## hb_common

基础组件库，包含常用的基础组件， extension，公共样式，工具类等。

1. 国际化初始化与初始化 dialog

```dart
 MaterialApp(
  builder: HbDialog.setup(),
  navigatorObservers: [HbDialog.navigatorObservers],
  localizationsDelegates: const <LocalizationsDelegate<
        Object?>>[
      //...
      HbCommonLocalizations.delegate,
    ],
  )
  <uses-permission android:name="android.permission.CAMERA"/>
```

2. 本地存储

```dart
await HbStorage.init();
runApp(const MyApp());
```

3. 通用列表，包含下拉刷新，上拉加载更多，回到顶部

- 使用

```dart
// 初始化分页入参的json key
HbPageApiCall.setUp(pageKey: "page", pageSizeKey: 'size');
// 实现model，后端分页的json需要继承HbPageModel
class PageModel implements HbPageModel {
  // 这里可以根据自动生成的json model进行修改
}


// 使用
 final HbPageApiCall<OrderModel> pageApiCall =
      HbPageApiCall<OrderModel>(Api.getList);
// Api.getList的类型是：Future<PageModel> getList(Map<String, dynamic> rowData)

// 下拉刷新
Future<void> _onRefresh() async {
  if (mounted) setState(() {});
  pageApiCall.refresh();
  await _loadMore();
}

// 上拉加载更多
Future<void> _loadMore() async {
  await pageApiCall.loadMore();
  if (mounted) setState(() {});
}

HbList(
  itemCount: pageApiCall.items.length,
  hasMore: pageApiCall.hasMore,
  loadMore: _loadMore,
  onRefresh: _onRefresh,
  skeleton: const OrderSkeleton(),
  itemBuilder: (context, index) {
    final item = pageApiCall.items[index];
    return OrderItem(item: item).onInkTap(() {
      HbNav.push(Routes.orderDetail, arguments: item);
    });
  },
),
```

4. 表单工具
```dart
// 第一步：继承选项model
// 这里可以根据自动生成的json model进行修改
class SelectItemModel implements HbSelectItemModel {}

// 使用
final HbFormController _form = HbFormController();

void _submit() {
  if (!_form.validate()) return;
  // 处理你的逻辑
}

FormSchema(formController: _form, children: [
  HbSelect(
    label: context.locale.token,
    radioController: widget.tokenController,
    enabled: false,
    selectItems: tokenListFromProvider,
  ),
  HbInput(
    label: context.locale.amount,
    controller: widget.amountController,
    hintText: context.locale.enterAmount,
    keyboardType: const TextInputType.numberWithOptions(
        decimal: true),
    inputFormatters: [HbAmountFormatter(digit: 6)],
  ),
]);
```
