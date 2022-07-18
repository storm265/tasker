import 'package:flutter_test/flutter_test.dart';

String _emailPattern = ("^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@"
    "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
    "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
    "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
    "[0-9]{1,2}|25[0-5]|2[0-4][0-9]))|"
    "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$");

// Write Regex Minimum eight characters, at least one letter and one number

void lol(){
  String text = 'daosDAOS';
  String pattern = '/^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\$/';
   RegExp regex = RegExp(_passwordPattern);
  if(text.length>8  && !regex.hasMatch(text)){
    print('ok');
  }
}
String _passwordPattern = ("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$");
//String _passwordPattern = "^(?=.*[A-Za-z])(?=.*d)[A-Za-zd]{8,}\$";

String _nicknamePattern =
    "^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]\$";

void main() {
  RegExp regex = RegExp(_passwordPattern);
  group('lol', () {


    test('test', () {
      expect(regex.hasMatch('daosDAOS'), isTrue);
    });
    test('password1', () => expect(!regex.hasMatch('daosDaos'), false));

    test('abcdefC1', () => expect(!regex.hasMatch('daos90321FIXED'), false));
    test('password2',
        () => expect(!regex.hasMatch('smesomesomesome32910390123'), false));
    test('password3', () => expect(!regex.hasMatch('MTIzNDU2Nzhx'), false));
    test('password4', () => expect(!regex.hasMatch('Wewedsddsadasdas'), false));
  });
}
