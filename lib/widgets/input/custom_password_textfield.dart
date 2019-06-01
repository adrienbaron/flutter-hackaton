import 'package:flutter/material.dart';
import 'package:flutter_mentor/config/application_themes.dart';
import 'package:flutter_mentor/helpers/ensure_visible_when_focused.dart';

const int _kMaxLength = 80;

class CustomPasswordTextField extends StatefulWidget {
  CustomPasswordTextField({
    Key key,
    @required this.controller,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.maxLength = _kMaxLength,
    this.labelText = "",
    this.hintText = "",
    this.errorText = "",
    this.icon,
  })  : assert(controller != null),
        super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final String labelText;
  final String hintText;
  final String errorText;
  final Icon icon;

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  FocusNode _focusNode;
  bool _privateFocusNode = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _privateFocusNode = true;
      _focusNode = FocusNode();
    } else {
      _focusNode = widget.focusNode;
    }
  }

  @override
  void dispose() {
    if (_privateFocusNode) {
      _focusNode?.dispose();
      _focusNode = null;
      _privateFocusNode = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EnsureVisibleWhenFocused(
      focusNode: _focusNode,
      child: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.text,
        obscureText: _obscureText,
        autofocus: widget.autofocus,
        focusNode: _focusNode,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        decoration: ApplicationThemes.textFieldDecoration().copyWith(
          labelText: widget.labelText,
          hintText: widget.hintText,
          errorText: widget.errorText,
          icon: widget.icon ?? SizedBox(width: 24.0,),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
