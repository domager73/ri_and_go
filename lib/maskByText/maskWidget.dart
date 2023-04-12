import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTextField extends StatefulWidget {
  final String? inputText;
  final List<TextInputFormatter>? mask;
  final Function? validateInput;
  final Color colorWidget;

  ProfileTextField(
      {Key? key,
        required this.inputText,
        required this.colorWidget,
        this.mask,
        this.validateInput})
      : super(key: key);

  @override
  _ProfileTextFieldState createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  String? _errorText;

  void _onChanged(String? value) {
    setState(() {
      _errorText =
      widget.validateInput != null ? widget.validateInput!(value) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: widget.mask,
      style: TextStyle(
        color: widget.colorWidget,
      ),
      onChanged: _onChanged,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        labelText: widget.inputText,
        labelStyle: TextStyle(
            color: widget.colorWidget, fontSize: 16, fontWeight: FontWeight.w500),
        suffixIcon: Icon(
          Icons.edit_outlined,
          size: 30,
        ),
        suffixIconColor: widget.colorWidget,
        contentPadding: EdgeInsets.only(bottom: 16.0),
        border: UnderlineInputBorder(borderSide: BorderSide(color: widget.colorWidget)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.colorWidget,
            width: 2.0,
          ),
        ),
        errorText: _errorText,
      ),
    );
  }
}
