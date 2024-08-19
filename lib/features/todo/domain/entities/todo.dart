import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Todo extends Equatable {
  const Todo({
    required this.title,
    this.id,
    this.description = '',
    this.isCompleted = false,
  });

  final String? id;
  final String title;
  final String description;
  final bool isCompleted;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object> get props => [id ?? '', title, description, isCompleted];
}
