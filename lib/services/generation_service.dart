import 'dart:math';

class PasswordGenerationService {
  String lowerCase = "qwertyuiopkljhgfdsazxcvbnm";
  String upperCase = "QWERTYUIOPLKASJDHFGNCMZBXV";
  String symbols = "!@#^&*";
  String numbers = "1234567890";

  String generatePassword({
    required bool includeLetters,
    required bool includeNumbers,
    required bool includeSymbols,
    required int length,
  }) {
    List<String> charSets = [];
    if (includeLetters) charSets.addAll([lowerCase, upperCase]);
    if (includeNumbers) charSets.add(numbers);
    if (includeSymbols) charSets.add(symbols);

    Random random = Random.secure();
    List<String> password = [];

    for (String charset in charSets) {
      password.add(charset[random.nextInt(charSets.length)]);
    }

    String allChars = charSets.join();
    while (password.length < length) {
      password.add(allChars[random.nextInt(allChars.length)]);
    }

    password.shuffle(random);

    return password.join();
  }
}
