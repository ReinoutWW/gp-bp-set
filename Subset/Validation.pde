// [VALIDATE] Validating sets
private static boolean isValidSet(String card1, String card2, String card3) {
    if(strIsNullOrEmpty(card1) || strIsNullOrEmpty(card2) || strIsNullOrEmpty(card3)) {
      return false;
    }
    
    if( card1.length() != 3 || card2.length() != 3 || card3.length() != 3) {
      return false;
    }
  
    return allSameOrDifferent(card1.charAt(0), card2.charAt(0), card3.charAt(0)) && // Number
           allSameOrDifferent(card1.charAt(1), card2.charAt(1), card3.charAt(1)) && // Color
           allSameOrDifferent(card1.charAt(2), card2.charAt(2), card3.charAt(2));  // Shape
}

private static boolean allSameOrDifferent(char a, char b, char c) {
    return (a == b && b == c) || (a != b && b != c && a != c);
}

// o(n,3) time complexity
int countValidSetsInGrid(String[][] playfield) {
  String[] cards = gridToArray(playfield);
  int count = 0;
  HashSet<String> uniqueSets = new HashSet<String>();

  for (int i = 0; i < cards.length; i++) {
    for (int j = i + 1; j < cards.length; j++) {
      for (int k = j + 1; k < cards.length; k++) {
        if (isValidSet(cards[i], cards[j], cards[k])) {
          String[] set = {cards[i], cards[j], cards[k]};
          Arrays.sort(set); // Sort to ensure uniqueness regardless of order
          String setKey = set[0] + "," + set[1] + "," + set[2]; // Create a unique key for the set
          
          println("Current possible set: " + setKey);
          
          if (!uniqueSets.contains(setKey)) {
            uniqueSets.add(setKey);
            count++;
          }
        }
      }
    }
  }

  return count;
}
