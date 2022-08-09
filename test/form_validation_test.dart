import 'package:flutter_test/flutter_test.dart';

String? validatePassword({required String password}) {
  // String passwordPattern = "(?=.*?[0-9])(?=.*?[A-Za-z]).+";
  String passwordPattern = "r^(?=.*[A-Za-z])(?=.*d)[A-Za-zd]{8,}\$";
  final regex = RegExp(passwordPattern);
  if (password.length < 8 && !regex.hasMatch(password)) {
    return 'WRONG';
  }
  return null;
}

void main() {
  group('lol', () {
    test('1', () {
      expect(validatePassword(password: 'DAOSdaos1'), null);
    });

    test('2', () {
      expect(validatePassword(password: 'daosDaos1'), null);
    });

    test('3', () => expect(validatePassword(password: 'daos90321FIXED'), null));

    test('4', () => expect(validatePassword(password: 'daos90321FIXED'), null));

    test(
        '5',
        () => expect(
            validatePassword(password: 'smesomesomesome32910390123'), null));

    test('6', () => expect(validatePassword(password: 'MTIzNDU2Nzhx'), null));

    test('7',
        () => expect(validatePassword(password: 'Wewedsddsadasdas'), null));
        test('8',
        () => expect(validatePassword(password: 'adad'), null));
            test('8',
        () => expect(validatePassword(password: 'adadD9'), null));
  });
}
