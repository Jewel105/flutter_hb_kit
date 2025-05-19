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
// 返回
HbNav.back(arguments: false);
// 跳转
HbNav.push(Routes.orderDetail);
// 传参
HbNav.push(Routes.orderDetail, arguments: item);
```


## hb_common
基础组件库，包含常用的基础组件， extension，公共样式，工具类等。
1. 国际化初始化与初始化dialog
```dart
 MaterialApp(
  builder: HbDialog.setup(),
  localizationsDelegates: const <LocalizationsDelegate<
        Object?>>[
      //...
      HbCommonLocalizations.delegate,
    ],
  )
  <uses-permission android:name="android.permission.CAMERA"/>
```

## hb_qr
二维码扫描, 生成二维码。
### 使用方法
#### 生成二维码
1. 生成二维码widget
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
## hb_dio
### 使用方法
1. 初始化
```dart
HbDio.setup();
```