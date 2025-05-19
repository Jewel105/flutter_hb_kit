class BaseEntity<T> {
  BaseEntity();

  // code
  late String code;
  // 数据
  T? data;
  // 消息
  String? msg;
  String? desc;
  late bool success;

  factory BaseEntity.fromJson(Map<String, dynamic> json) =>
      _$BaseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BaseEntityToJson(this);

  @override
  String toString() {
    return 'BaseEntity{code: $code, data: $data,msg: $msg,desc: $desc, success: $success}';
  }
}

BaseEntity<T> _$BaseEntityFromJson<T>(Map<String, dynamic> json) =>
    BaseEntity<T>()
      ..code = json['code'] as String
      ..data = json['data'] as T?
      ..msg = json['msg'] as String?
      ..desc = json['desc'] as String?
      ..success = json['success'] as bool;

Map<String, dynamic> _$BaseEntityToJson(BaseEntity<Object?> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'desc': instance.desc,
      'success': instance.success,
    };
