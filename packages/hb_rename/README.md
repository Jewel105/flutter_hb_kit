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
