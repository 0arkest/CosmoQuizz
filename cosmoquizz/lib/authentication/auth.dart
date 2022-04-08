import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  // register a new account
  static Future<User?> registration({
    required String username,
    required String email,
    required String password,
  })
  async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(username);
      await user.reload();
      user = auth.currentUser;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      }
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
    catch (e) {
      print(e);
    }

    return user;
  }

  // log in with an existing account
  static Future<User?> signIn({
    required String email,
    required String password,
  })
  async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }
      else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    catch (e) {
      print(e);
    }

    return user;
  }

  // recover account password
  static Future<User?> recoverPassword({
    required String email,
  })
  async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'auth/user-not-found') {
        print('We couldn\'t find an account with the email address provided');
      }
    }
    catch (e) {
      print(e);
    }

    return null;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}
