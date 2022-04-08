class Validator {
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
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

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

  static String? validateFirstName({required String? firstName}) {
    if (firstName == null) {
      return null;
    }

    if (firstName.isEmpty) {
      return 'Last name can\'t be empty';
    }

    return null;
  }

  static String? validateLastName({required String? lastName}) {
    if (lastName == null) {
      return null;
    }

    if (lastName.isEmpty) {
      return 'Last name can\'t be empty';
    }

    return null;
  }

  static String? validateSchool({required String? school}) {
    if (school == null) {
      return null;
    }

    if (school.isEmpty) {
      return 'School can\'t be empty';
    }

    return null;
  }

  static String? validateBirthday({required String? birthday}) {
    if (birthday == null) {
      return null;
    }

    if (birthday.isEmpty) {
      return 'Last name can\'t be empty';
    }

    return null;
  }

  static String? validateEmergencyContact({required String? emergencyContact}) {
    if (emergencyContact == null) {
      return null;
    }

    if (emergencyContact.isEmpty) {
      return 'Last name can\'t be empty';
    }

    return null;
  }
}
