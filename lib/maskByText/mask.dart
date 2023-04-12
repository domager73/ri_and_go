import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


var maskFormatterTelephone = new MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy
);

var maskFormatterDate = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy
);

String? validEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? validLengthForPwd(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (value.length < 5) {
    return 'This password is too short';
  }
  return null;
}

String? validForEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (!value.contains('@')) {
    return 'Type correct email';
  }
  return null;
}

String? validTelephone(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  } else if (value.length <= 11) {
    return 'Type correct email';
  }
  return null;
}



