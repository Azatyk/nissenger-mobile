List<String> gradeLetters = ["A", "B", "C", "D", "K", "L", "M", "N", "E"];

String mapIndexToGradeLetter({required int index}) {
  return gradeLetters[index];
}

int mapGradeLetterToIndex({required String letter}) {
  return gradeLetters.indexOf(letter);
}
