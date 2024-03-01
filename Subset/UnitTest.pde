// This script will function as a unit test script. We will validate different values on startup.

// Main orchestration  
boolean startUnitTest() throws Exception {
   HashMap<String, Boolean> results = new HashMap<String, Boolean>();
   
   results.put("Generating cards", TEST_GenerateCardsComprehensive());
   results.put("Set validation", TEST_ValidSet());

   
   for(Map.Entry<String, Boolean> entry : results.entrySet()) {
     String test = entry.getKey();
     boolean pass = entry.getValue();
     
     println("|Unit test| " + (pass ? "[SUCCESS]" : "[FAIL]") + " [" + test + "]");

     if(!pass) {
       throw new Exception("|Unit test| " + test + " failed. Resolve this issue.");
     }
   } 
   
   return true;
}  

boolean TEST_GenerateCardsComprehensive() {
    // Scenarios setup
    Object[][] scenarios = {
        {new String[]{"red", "green", "blue", "yellow", "purple"}, new String[]{"eclipse", "square", "triangle"}, 3}, // More colors
        {new String[]{"red", "green", "blue"}, new String[]{"eclipse", "square", "triangle", "circle", "hexagon"}, 3}, // More shapes
        {new String[]{"red", "green", "blue"}, new String[]{"eclipse", "square", "triangle"}, 5}, // Higher max shapes per card
        {new String[]{"red"}, new String[]{"eclipse"}, 1}, // Single color and shape
        {new String[]{}, new String[]{}, 3}, // Empty colors and shapes
    };
    
    try {
      for (Object[] scenario : scenarios) {
        String[] colors = (String[]) scenario[0];
        String[] shapes = (String[]) scenario[1];
        int maxShapesPerCard = (Integer) scenario[2];

        LinkedList<String> cards = generateCards(colors, shapes, maxShapesPerCard);
        int expectedAmountOfCards = colors.length * shapes.length * maxShapesPerCard;
        
        if(expectedAmountOfCards != cards.size()) {
          return false; // When at least one scenario fails
        }
      }
    } catch (Exception e) {
      return false;
    }

    return true; // Assuming all scenarios passed after proper validation
}

boolean TEST_ValidSet() {
    Object[][] scenarios = {
        { new String[]{"1gs", "2be", "3rt" }, true},
        { new String[]{"1ge", "2ge", "3ge" }, true},
        { new String[]{"1ge", "2gt", "3gs" }, true},
        { new String[]{"1g", "2gt", "3" }, false},
        { new String[]{"1ge", "2gt" }, false},
        { new String[]{"1", "2g", "3g" }, false},
        { new String[]{ }, false}
    };
    
    try {
      for (Object[] scenario : scenarios) {
          String[] set = (String[]) scenario[0];
          boolean expectedResult = (boolean) scenario[1];
          
          String card1 = stringArrayTryGetValue(set, 0);
          String card2 = stringArrayTryGetValue(set, 1);
          String card3 = stringArrayTryGetValue(set, 2);
          
          if(isValidSet(card1, card2, card3) != expectedResult) {
            return false;
          }
      }
    } catch (Exception e) {
      return false;
    }
    
    return true;
}

String stringArrayTryGetValue(String[] arr, int index) {
  return (index >= arr.length) ? "" : arr[index];
}
