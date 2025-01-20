class Validators {
  static String? validateEmailORMobile(String? value, {bool isEmailId = true}) {
    String emailPattern = r'^.+@[a-zA-Z0-9]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regex = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return "Please enter Email or Phone number";
    } else if (!regex.hasMatch(value.trim()) && isEmailId) {
      return "Invalid Email";
    } else if (!isEmailId && value.length <= 5) {
      return "Invalid mobile number";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    String emailPattern = r'^.+@[a-zA-Z0-9]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regex = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return "Email should not be empty";
    } else if (!regex.hasMatch(value.trim())) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name should not be empty";
    } else if (value.length <= 3) {
      return "Name is invalid";
    } else {
      return null;
    }
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return "OTP field can not be empty";
    } else if (value.length != 6) {
      return "Invalid OTP Number";
    } else {
      return null;
    }
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password should not be empty";
    } else {
      if (!RegExp(r'^.{8,}$').hasMatch(value)) {
        return "Password should be minimum 8 characters";
      } else if (!RegExp('.*[a-z].*').hasMatch(value)) {
        return "Should have at least one lower character";
      } else if (!RegExp('.*[A-Z].*').hasMatch(value)) {
        return "Should have at least one upper character";
      } else if (!RegExp(".*[0-9].*").hasMatch(value)) {
        return "Should contain at least one number";
      } else if (!RegExp(".*[!@#&*~\$%_].*").hasMatch(value)) {
        return "Should contain at least one special character";
      } else {
        return null;
      }
    }
  }

  static String? validateConfirmPassword(
      String? newPassword, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm password should not be empty";
    } else {
      if (newPassword == null || newPassword.isEmpty) {
        return null;
      } else if (confirmPassword != newPassword) {
        return "Password doesn't match";
      } else {
        return null;
      }
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password should not be empty";
    } else if (value.length <= 4) {
      return "Please enter a valid password";
    } else {
      return null;
    }
  }

  static String? validateService(String? value, String title) {
    if (value == null || value.isEmpty) {
      return "$title should not be empty";
    } else if (value == "null") {
      return "Please select different one";
    } else {
      return null;
    }
  }

  static String? validateServiceList(int length, String title) {
    if (length == 0) {
      return "$title must be selected";
    } else {
      return null;
    }
  }

  static String? validateCommon(String? value, String title) {
    if (value == null || value.isEmpty) {
      return "$title should not be empty";
    }
    if (value.length <= 3) {
      return "$title is invalid";
    } else {
      return null;
    }
  }

  static String? validateChangeEmailORMobile(
      String? currentValue, String? newValue,
      {bool isEmailId = true}) {
    String emailPattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regex = RegExp(emailPattern);
    if (newValue == null || newValue.isEmpty) {
      return "Please enter Email or Phone number";
    } else if (!regex.hasMatch(newValue.trim()) && isEmailId) {
      return "Invalid Email";
    } else if (!isEmailId && newValue.length <= 5) {
      return "Invalid mobile number";
    } else {
      if (newValue == currentValue && isEmailId) {
        return "Please enter different email";
      } else if (newValue == currentValue && !isEmailId) {
        return "Please enter different mobile number";
      }
      return null;
    }
  }
}
