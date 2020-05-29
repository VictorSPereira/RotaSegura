class Validations {
  static bool cepValidation(String value) {
    Pattern pattern = r'^[0-9]{5}-[0-9]{3}$';
    RegExp regex = new RegExp(pattern);

    if (regex.hasMatch(value))
      return true;
    else
      return false;
  }
}