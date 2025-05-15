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
```dart
import 'package:hb_router/hb_router.dart';

// ...
MaterialApp(
  // RouteConfig.routes是您的路由配置
  onGenerateRoute: HbRouter(RouteConfig.routes).generateRoute,
  navigatorKey: HbRouter.key,
);
//...
```
#### 路由配置
```dart
// RouteConfig.routes示例
// arguments是跳转时候的传参
class RouteConfig {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
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

