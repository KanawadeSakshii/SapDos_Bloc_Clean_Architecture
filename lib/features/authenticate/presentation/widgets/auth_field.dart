import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? iconColor;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.iconColor});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isObscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: widget.iconColor,
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                      color: AppPallete.greyColor,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null),
        validator: (value) {
          if (value!.isEmpty) {
            return "${widget.hintText} is missing";
          }
          return null;
        },
        obscureText: _isObscured,
      ),
    );
  }
}
