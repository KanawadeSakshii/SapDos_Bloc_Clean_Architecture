import 'package:bloc_project/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? iconColor;
  final void Function(dynamic value) onChanged;
  final String? errorText;

  const AuthField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    required this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  _AuthFieldState createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool isTextObscured;

  @override
  void initState() {
    super.initState();
    isTextObscured = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(1.5),
      child: Container(
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                      isTextObscured ? Icons.visibility : Icons.visibility_off,
                      color: AppPallete.greyColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isTextObscured = !isTextObscured;
                      });
                    },
                  )
                : null,
            border: const OutlineInputBorder(),
            focusColor: AppPallete.gradient1,
            errorText: widget.errorText,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "${widget.hintText} is missing";
            }
            return null;
          },
          obscureText: isTextObscured,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
