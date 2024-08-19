import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@immutable
@JsonSerializable()
class TodoModel extends Todo {
  TodoModel(
      {String? id, required super.title, super.description, super.isCompleted})
      : super(id: id ?? const Uuid().v4());

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static TodoModel fromJson(JsonMap json) => _$TodoModelFromJson(json);

  JsonMap toJson() => _$TodoModelToJson(this);
}

typedef JsonMap = Map<String, dynamic>;
