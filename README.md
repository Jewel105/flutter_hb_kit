# flutter_kit

hambit flutter 公共组件库

## hb_router

路由管理工具，支持页面间传参，页面间跳转动画。

### 使用方法

1. 安装

```yaml
dependencies:
  hb_router:
    git:
      url: https://xlnhy.hamber.io/wallet/front/flutter_kit.git
      # 某次提交的commit，也可以是分支，tag
      ref: 8b60b11d7fe928431cbd0758f2cda60e5d1ed59e
      path: packages/hb_router
```

2. 初始化

- 目前只支持一个全局中间件

```dart
import 'package:hb_router/hb_router.dart';

// ...
MaterialApp(
  // RouteConfig.routes是您的路由配置，可以设置一个全局中间件middleware
  onGenerateRoute: HbRouter(
                    RouteConfig.routes,
                    middleware: RouterMiddleware(),
                  ).generateRoute,
  navigatorKey: HbRouter.key,
);
//...
```

#### 路由配置

```dart
// RouteConfig.routes示例
// arguments是跳转时候的传参
class RouteConfig {
  static final Map<String, HbWidgetBuilder> routes = <String, HbWidgetBuilder>{
    '/': (Object? arguments) => const IndexPage(),
    '/order_detail': (Object? arguments) =>
        OrderDetailPage(order: arguments as OrderModel),
  };
}
```

#### 页面间跳转与传参

```dart
// 页面返回
HbNav.back(arguments: false);
// 弹窗关闭
HbNav.pop(arguments: false);
// 跳转
HbNav.push(Routes.orderDetail);
// 传参
HbNav.push(Routes.orderDetail, arguments: item);
```

#### 其他信息

```dart
// 页面路由栈
print(HbRouter.history)
// 当前页面
print(HbRouter.currentRoute)
// 全局context
print(HbRouter.key.currentState!.context)

```

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

## hb_qr

二维码扫描, 生成二维码。

### 使用方法

#### 生成二维码

1. 生成二维码 widget

```dart
HbQrBox(data: 'https://www.jewel.io');
```

#### 扫描二维码

- 需要添加权限和国际化配置

1. 国际化初始化

```dart
 MaterialApp(
  localizationsDelegates: const <LocalizationsDelegate<
        Object?>>[
      //...
      HbQrLocalizations.delegate,
    ],
  )
  <uses-permission android:name="android.permission.CAMERA"/>
```

2. 权限配置

- Android， AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

- iOS，ios/Runner/Info.plist

```plist
<key>NSCameraUsageDescription</key>
<string>我们需要使用摄像头来扫描二维码</string>
```

3. 使用：扫描二维码

```dart
final result = await HbQr.scan();
```

## hb_rename

> 一键更改 app 名称，多环境配置，packageId，目前仅支持初始化时使用，多次使用会存在重复代码，需要手动清理

### 使用方法

1. 下载到开发依赖

```yaml
dev_dependencies:
  hb_rename:
    git:
      url: https://xlnhy.hamber.io/wallet/front/flutter_kit.git
      # 某次提交的commit，也可以是分支，tag
      ref: 8b60b11d7fe928431cbd0758f2cda60e5d1ed59e
      path: packages/hb_rename
```

2. 项目根目录下使用

```shell
dart run hb_rename all -a HamBit -b com.hambit.equipment
```
