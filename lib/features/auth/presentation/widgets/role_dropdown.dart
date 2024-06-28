import 'package:flutter/material.dart';
import 'package:bloc_project/features/auth/data/model/user_model.dart';

class RoleDropdown extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole?> onChanged;

  const RoleDropdown({
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<UserRole>(
        value: selectedRole,
        onChanged: (UserRole? value) {
          onChanged(value);
        },
        items: UserRole.values.map((UserRole role) {
          return DropdownMenuItem<UserRole>(
            value: role,
            child: Text(role.name),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Select Role',
        ),
      ),
    );
  }
}
