import 'dart:async';

class AuthService {
  static const String correctPassword = "mylogin1234";
  Future<void> signIn(String inputPassword) {
    final completer = Completer<void>();
    Future.delayed(Duration(seconds: 3), (){
      inputPassword == correctPassword ? completer.complete()
          : completer.completeError('Incorrect password, please try again');
    });
    return completer.future;
  }
}