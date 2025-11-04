## 使用
1. 国际化初始化

```dart
 MaterialApp(
  localizationsDelegates: const <LocalizationsDelegate<
        Object?>>[
      //...
      HbChartLocalizations.delegate,
    ],
  )
```