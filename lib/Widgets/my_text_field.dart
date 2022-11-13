import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(bool isObscure)? onHasFocus;
  final Function(bool isObscure)? onObscureText;
  final Function(String text)? onChanged;

  const MyTextField({
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.onHasFocus,
    this.onObscureText,
    this.onChanged,
    super.key,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool _isObscure = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_refresh);
  }

  void _refresh() {
    if (_focusNode.hasFocus && widget.onHasFocus != null) {
      widget.onHasFocus?.call(_isObscure);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_refresh);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => FocusScope.of(context).requestFocus(_focusNode),
      child: TextField(
        focusNode: _focusNode,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.only(left: 8.0),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                    if (widget.onObscureText != null) {
                      widget.onObscureText?.call(_isObscure);
                    }
                  },
                )
              : null,
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ? _isObscure : widget.obscureText,
        onChanged: widget.onChanged,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black87),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
