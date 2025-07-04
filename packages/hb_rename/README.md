## hb_rename

> 一键更改 app 名称，多环境配置，packageId

![example image](example.png)

### 使用方法

1. 下载到开发依赖 

```yaml
dev_dependencies:
  hb_rename: 0.0.2
```

2. 项目根目录下使用
> 此命令会自动将APP名称改为YourName，包名改为com.you.app，并且自动区分生产环境和开发环境，开发环境的名称自动为：YourName_DEV, 包名也会自动加上dev

```shell
dart run hb_rename all -a YourName -b com.you.app
```

- 运行项目时，加上dart-defines=APP_ENV
```shell
flutter run --dart-define=APP_ENV=dev # 开发环境 运行app的包名为com.you.app.dev
flutter run --dart-define=APP_ENV=pro # 生产环境
```


