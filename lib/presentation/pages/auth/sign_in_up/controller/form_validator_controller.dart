class FormValidatorController {
  String? validateEmail({required String email}) {
    RegExp regex = RegExp("^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@"
        "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
        "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
        "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
        "[0-9]{1,2}|25[0-5]|2[0-4][0-9]))|"
        "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$");
    if (email.isEmpty || email.trim().isEmpty) {
      return 'Email cant be empty';
    } else if (!regex.hasMatch(email)) {
      return 'Incorrect email';
    }
    return null;
  }

  String? validatePassword({required String password}) {
    final regex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
    if (password.isEmpty || password.trim().isEmpty) {
      return 'This field is required 😐';
    } else if (!regex.hasMatch(password)) {
      return 'Minimum 8 characters, at least 1 letter and 1 number';
    } else {
      return null;
    }
  }

  String? validateNickname({required String username}) {
    RegExp regex =
        RegExp("^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$");

    if (username.isEmpty || username.trim().isEmpty) {
      return 'This field is required 😐';
    } else if (!regex.hasMatch(username)) {
      return 'Incorrent nickName';
    }
    return null;
  }
}
