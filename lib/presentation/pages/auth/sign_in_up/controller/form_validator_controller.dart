import 'package:email_validator/email_validator.dart';

class FormValidatorController {
  String? validateEmail({required String email}) {
    if (email.trim().isEmpty) {
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
    }
    if (password.trim().length < 6) {
      return 'Password must be at least 6 characters in length';
    }

    return null;
  }

  String? validateUsername({required String username}) {
    if (username.isEmpty) {
      return 'Username is cannot be empty';
    } else if (username.length <= 5) {
      return 'Username must be at least 5 characters';
    } else {
      return null;
    }
  }

  // bool isContainsForbittedSymbols({required String email}) {
  //   String forbittenSymbols = "!#\$%&'*+-/=?^_`{|}~";
  //   List<String> forbittenSymbolsList = forbittenSymbols.split('');

  //   List<String> newEmail = email.split('');
  //   for (int i = 0; i < email.length; i++) {
  //     for (int j = 0; j < forbittenSymbols.length; j++) {
  //       if (newEmail[i] == forbittenSymbolsList[j]) {
  //         return false;
  //       }
  //     }
  //   }
  //   return true;
  // }
}
