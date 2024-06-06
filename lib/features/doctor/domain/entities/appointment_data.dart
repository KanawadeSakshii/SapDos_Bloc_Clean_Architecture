import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CustomDropdownItem {
  final IconData icon;
  final String name;
  final int age;
  final String time;
  final String status;
  final String issueDescription;

  CustomDropdownItem({
    required this.icon,
    required this.name,
    required this.age,
    required this.time,
    required this.status,
    required this.issueDescription,
  });
}
