## hb_router

路由管理工具，支持页面间传参，页面间跳转动画。

### 使用方法

1. 安装

```yaml
dependencies:
  hb_router: 0.0.1
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
                    middleware: LoginMiddleware(),
                  ).generateRoute,
  navigatorKey: HbRouter.key,
);
//...
```

- 全局路由中间件

```dart
import 'package:flutter/material.dart';
import 'package:hb_common/hb_common.dart';
import 'package:hb_router/hb_router.dart';

class LoginMiddleware extends HbMiddleware {
  @override
  Widget? execute(String? route) {
    var skipRoutes = [Routes.register, Routes.login];
    if (skipRoutes.contains(route)) return null;
    var token = HbStorage.get(AppConstant.TOKEN);
    if (token == null || token.isEmpty) {
      return LoginPage();
    }
    return null;
  }
}


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
