parseIngredientsAndDirections(String text) {
  List<String> result = [];
  List<String> stopWords = ["Steps", "Directions", "Instructions"];
  stopWords.forEach((stopWord) {
    String tmp = stopWord + ":\n";
    if (text.contains(tmp)) {
      result = text.split(tmp);
    }
  });
  return result;
}