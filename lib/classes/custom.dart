class CustomFunctions {
  static final CustomFunctions instance = CustomFunctions._internal();

  factory CustomFunctions() {
    return instance;
  }

  CustomFunctions._internal();

  String resolveJson(String json, int skip) {
    String result = "";
    bool start = false;

    for (var i = 0; i < json.length; i++) {
      if (json[i] == "{") {
        if (skip == 0) {
          start = true;
        } else {
          --skip;
        }
      }

      if (start) {
        result += json[i];
      }

      if (json[i] == "}" && start) {
        break;
      }
    }

    return result;
  }
}
