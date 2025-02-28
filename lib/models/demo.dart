class Demo {
  Demo({
    this.th2,
    this.th3,
    this.th7,
  });

  Demo.fromJson(dynamic json) {
    th2 = json['Thứ 2'] != null ? json['Thứ 2'].cast<String>() : [];
    th3 = json['Thứ 3'] != null ? json['Thứ 3'].cast<String>() : [];
    th7 = json['Thứ 7'] != null ? json['Thứ 7'].cast<String>() : [];
  }

  List<String>? th2;
  List<String>? th3;
  List<String>? th7;

  Demo copyWith({
    List<String>? th2,
    List<String>? th3,
    List<String>? th7,
  }) =>
      Demo(
        th2: th2 ?? this.th2,
        th3: th3 ?? this.th3,
        th7: th7 ?? this.th7,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Thứ 2'] = th2;
    map['Thứ 3'] = th3;
    map['Thứ 7'] = th7;
    return map;
  }
}
