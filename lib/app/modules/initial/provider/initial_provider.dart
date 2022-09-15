import 'package:ayiconnect/router/router.dart';
import 'package:flutter/cupertino.dart';

class InitialProvider extends ChangeNotifier {
  checkCredentials() async {
    bool isLoggedIn = true;
    if (isLoggedIn) {
      router.go('/find-helper');
    }
  }
}
