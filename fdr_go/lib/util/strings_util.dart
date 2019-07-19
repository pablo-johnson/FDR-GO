String getShortName(String string) {
  if (string != null && string.isNotEmpty) {
    List<String> words = string.split(" ");
    StringBuffer stringBuffer = new StringBuffer();
    if (words.length > 1) {
      stringBuffer.write(words[0].substring(0, 1));
      stringBuffer.write(words[1].substring(0, 1));
    } else if (words.length > 0) {
      stringBuffer.write(words[0].substring(0, 1));
    }
    return stringBuffer.toString();
  } else {
    return "";
  }
}

String enumName(Object o) => o.toString().split('.').last;
