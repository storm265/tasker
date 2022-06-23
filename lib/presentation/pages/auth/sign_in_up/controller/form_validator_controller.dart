class FormValidatorController {
  String? validateEmail(String email) {
      const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
        final RegExp regex = RegExp(pattern);
    if (email.isEmpty ) {
      return 'Email is cannot be empty';
    } else if (!regex.hasMatch(email)) {
      return 'Incorrect email';
    } else {
      return null;
    }
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is cannot be empty';
    } else if (password.length <= 6) {
      return 'Password must be at least 6 characters';
    } else {
      return null;
    }
  }

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username is cannot be empty';
    } else if (username.length <= 5) {
      return 'Username must be at least 5 characters';
    } else {
      return null;
    }
  }
  
}
