import 'package:flutter_test/flutter_test.dart';

String _emailPattern = ("^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@"
    "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
    "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
    "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
    "[0-9]{1,2}|25[0-5]|2[0-4][0-9]))|"
    "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$");

String _passwordPattern = "^(?=.*[A-Za-z])(?=.*d)[A-Za-zd]{8,}\$";

String _nicknamePattern =
    "^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$";

void main() {
  RegExp regex = RegExp(_passwordPattern);
  group('lol', () {
    test('password validation test',
        () => expect(!regex.hasMatch('daosDAOS'), false));
    test('password validation test',
        () => expect(!regex.hasMatch('daos90321FIXED'), false));
    test('password validation test',
        () => expect(!regex.hasMatch('somesomesomesome32910390123'), false));
    test('password validation test',
        () => expect(!regex.hasMatch('dsada323434DSDSD'), false));
    test('password validation test',
        () => expect(!regex.hasMatch('WEWEdsddsadasdas'), false));
    test('password validation test',
        () => expect(!regex.hasMatch('akaada12345FFFFF'), false));
  });
}
