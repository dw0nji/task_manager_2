import 'package:flutter/widgets.dart';


class AppAuth extends ChangeNotifier {
  // notify all listeners if a user has been logged out

  bool _signedIn = false;

  bool get signedIn => _signedIn;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password for debugging.
    // TODO: Add logic to call backend
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

}