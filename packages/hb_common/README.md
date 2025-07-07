## hb_common

基础组件库，包含常用的基础组件（按钮，列表，表单，AppBar，Icon）， extension，公共样式，工具类等。

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

// 使用
await HbStorage.set("key",value);
HbStorage.get("key");

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
// 第一步：继承选项model，用于上拉选项列表
// 这里可以根据自动生成的json model进行修改
class SelectItemModel implements HbSelectItemModel {}

// 使用
final HbFormController _form = HbFormController();

void _submit() {
  if (!_form.validate()) return;
  // 处理你的逻辑
}

HbForm(formController: _form, children: [
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

5. 国际化

```dart
 MaterialApp(
  localizationsDelegates: const <LocalizationsDelegate<
        Object?>>[
      //...兼容hbcommon的国际化
       ...HbCommonLocalizations.localizationsDelegates,
    ],
  )
```

6. 全局颜色

```dart
  // 初始化hb颜色
  AppColor.init();
  // 使用
  HbColor.textBlack;
```

```dart
// 需要您自定义自己的颜色
class AppColor {
  static init() {
    HbColor.setup(
      // 主体色
      mainDarkColor: const Color(0xFF0C3294),
      mainLightColor: const Color(0xFF0C3294),
      // 背景色
      bgWhite: const Color(0xffFFFFFF),
      bgBlack: const Color(0xff1F1F1F),
      bgGrey: const Color(0xffF3F3F3), // 未激活背景色
      bgGreyLight: const Color(0xffF7F7F7),
      bgGreyDark: const Color(0xffECECEC),
      bgSuccessLight: const Color.fromRGBO(98, 201, 27, 0.15), // 涨，成功
      bgErrorLight: const Color.fromRGBO(254, 81, 82, 0.15), // 涨，成功
      bgWarnLight: const Color.fromRGBO(255, 162, 13, 0.15), // 涨，成功
      // 文字色
      textBlack: Colors.black,
      textWhite: Colors.white,
      textGrey: const Color(0xFF8F8F8F),
      textGreyLight: const Color(0xFF959595),
      textGreyDark: const Color(0xFF444745),
      textError: const Color(0xffFE5152),
      textSuccess: const Color(0xff62C91B), // 涨，成功
      textWarn: const Color(0xffFFA20D), // 警告，提示
      // 边框颜色
      lineGrey: const Color(0xffF1F1F1),
      // 遮罩层颜色
      shadowBlack: const Color.fromRGBO(0, 0, 0, 0.15),
    );
  }
}
```

7. 常用 extension

```dart
// 时间格式化
"1748577780".yMd;
1748577780.yMMMMd;
1748577780.yMdHms;
DateTime.now().yMdHm;
DateTime.now().dateToFormat(customFormat:DateFormat.yMd);
// widget extension pt pr等
Text("text").pt(32.w);
// 数字格式化
"123.2322".formatNum;
// 文字转为widget
"text".text12();
```

8. 图标，支持网络，svg，本地图标，并缓存到本地

```dart
HbIcon(
  icon: "http://",
  width: 64.w,
)
```

> 无法囊括所有，其他功能请看源码
