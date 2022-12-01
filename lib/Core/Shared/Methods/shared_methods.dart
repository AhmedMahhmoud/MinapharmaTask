

class SharedMethods {
  static validate(String value, String validationOn) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{5,}$');
    if (value.isEmpty) {
      return "This field is required";
    } else {
      if (!regex.hasMatch(value)) {
        if (value.length < 5) {
          return "$validationOn must be at least 5 characters";
        } 
      }
    }
  }
}
