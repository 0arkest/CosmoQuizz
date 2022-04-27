class Validator {
  static String? validateTextInput({required String? textInput}) {
    if (textInput == null) {
      return null;
    }

    if (textInput.isEmpty) {
      return 'This field cannot be left blank';
    }

    return null;
  }

  static String? validateUsername({required String? username}) {
    if (username == null) {
      return null;
    }

    if (username.isEmpty) {
      return 'Username can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
    );

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    }
    else if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    }
    else if (password.length < 6) {
      return 'The length of password should be greater than 5';
    }

    return null;
  }
}
