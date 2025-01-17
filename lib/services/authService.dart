import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  // Google Sign in
  signInWithGoogle() async {
    // Begin interactive process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain authentication details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}