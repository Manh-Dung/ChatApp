class Validator {
  static bool validateEmail(String email) => RegExp(
          r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$")
      .hasMatch(email);

  static bool validatePhone(String phone) =>
      RegExp(r"^\+?[0-9]{3}-?[0-9]{6,12}$").hasMatch(phone);
}
