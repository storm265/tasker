// String _emailPattern = ("^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@"
//     "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
//     "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
//     "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
//     "[0-9]{1,2}|25[0-5]|2[0-4][0-9]))|"
//     "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$");

// String _passwordPattern = """^(?=.*[A-Za-z])(?=.*d)[A-Za-zd]{8,}\$""";
// String _nicknamePattern =
//     "^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$";

import 'package:email_validator/email_validator.dart';

class FormValidatorController {
  // RegExp regex = RegExp(_emailPattern);
  // String? validateEmail({required String email}) {
  //   if (email.trim().isEmpty) {
  //     return 'Email cant be empty';
  //   } else if (!regex.hasMatch(_emailPattern)) {
  //     return 'Incorrect email';
  //   }
  //   return null;
  // }
  String? validateEmail({required String email}) {
    if (email.isEmpty || email.trim().isEmpty) {
      return 'Email cant be empty';
    } else if (!EmailValidator.validate(email, true)) {
      return 'Incorrect email';
    } else {
      return null;
    }
  }

  String? validatePassword({required String password}) {
    if (password.isEmpty || password.trim().isEmpty) {
      return 'This field is required';
    } else if (password.trim().length < 6) {
      return 'Password must be at least 6 characters in length';
    }

    return null;
  }
  //   String? validatePassword({required String password}) {
  //   RegExp regex = RegExp(_passwordPattern);
  //   if (password.isEmpty || password.trim().isEmpty) {
  //     return 'This field is required';
  //   } else if (password.trim().length < 6) {
  //     return 'Password must be at least 6 characters in length';
  //   } else if (!regex.hasMatch(_passwordPattern)) {
  //     return 'Incorrect password';
  //   }

  //   return null;
  // }

  // String? validateNickname({required String username}) {
  //   RegExp regex = RegExp(_nicknamePattern);

  //   if (username.isEmpty || username.trim().isEmpty) {
  //     return 'This field is required';
  //   } else if (username.length <= 3) {
  //     return 'Username must be at least 3 characters';
  //   } else if (!regex.hasMatch(_nicknamePattern)) {
  //     return 'Incorrent nickName';
  //   }
  //   return null;
  // }
  String? validateNickname({required String username}) {
    if (username.isEmpty || username.trim().isEmpty) {
      return 'This field is required';
    } else if (username.length <= 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }
}
