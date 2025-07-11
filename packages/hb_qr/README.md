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
```

2. 权限配置

- Android， AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

- iOS，ios/Runner/Info.plist

```plist
	<key>NSCameraUsageDescription</key>
	<string>This app needs camera access to scan QR codes</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>This app needs photos access to get QR code from photo library</string>
```

- macOS, macos/Runner/Info.plist
```plist
	<key>NSCameraUsageDescription</key>
	<string>This app needs camera access to scan QR codes</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>This app needs photos access to get QR code from photo library</string>
```
在Xcode中启用权限：XCode -> Signing & Capabilities
![XCode -> Signing & Capabilities, 勾选camera](mac-xcode.png)


3. 使用：扫描二维码

```dart
final result = await HbQr.scan();
// result如果为空则表示没有识别到二维码
```
