abstract class Validator {
  static String? requiredValidator(String? value) {
    if (value != null && value.trim().isNotEmpty) return null;
    return '';
  }
}
