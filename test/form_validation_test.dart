import 'package:flutter_test/flutter_test.dart';

// Write Regex Minimum eight characters, at least one letter and one number

bool isValidPassword(String yourText) {
  // String pattern = ("^[a-zA-Z][1-9]\$");
  String pattern = r"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$";
  RegExp regex = RegExp(pattern);
  if (yourText.length > 8 && !regex.hasMatch(yourText)) {
    return true;
  } else {
    return false;
  }
}

// String _passwordPattern = ("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$");

void main() {
  group('lol', () {
    test('test', () {
      expect(isValidPassword('DAOSdaos1'), true);
    });
    test('test', () {
      expect(isValidPassword('daosDaos1'), true);
    });
    test('password1', () => expect(isValidPassword('daos90321FIXED'), true));

    test('abcdefC1', () => expect(isValidPassword('daos90321FIXED'), true));
    test('password2',
        () => expect(isValidPassword('smesomesomesome32910390123'), true));
    test('password3', () => expect(isValidPassword('MTIzNDU2Nzhx'), true));
    test('password4', () => expect(isValidPassword('Wewedsddsadasdas'), true));
  });
}
