import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(3)
  String iconName;

  @override
  String toString() {
    return '$id: $name';
  }
}
