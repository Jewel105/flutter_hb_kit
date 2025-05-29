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
