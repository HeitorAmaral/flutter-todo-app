import 'package:flutter/material.dart';

class Todo {
  final String id;
  final String description;
  final String iconUrl;

  const Todo({
    this.id,
    @required this.description,
    @required this.iconUrl,
  });
}
