import 'package:flutter_test/flutter_test.dart';

bool isValidPassword(String yourText) {
  String pattern = "^[a-zA-Z][1-9]\$";
  // String pattern = r"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$";
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(yourText)) {
    return true;
  } else {
    return false;
  }
}

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
