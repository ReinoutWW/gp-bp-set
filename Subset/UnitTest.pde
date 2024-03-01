// This script will function as a unit test script. We will validate different values on startup.

// Main orchestration  
void StartUnitTest() {
   HashMap<String, Boolean> results = new HashMap<String, Boolean>();
   
   results.put("Generating cards", TEST_GenerateCardsComprehensive());
   
   for(Map.Entry<String, Boolean> entry : results.entrySet()) {
     String test = entry.getKey();
     boolean pass = entry.getValue();
     
     println("|Unit test| " + (pass ? "[SUCCESS]" : "FAIL") + " [" + test + "]");
   } 
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

    for (Object[] scenario : scenarios) {
        String[] colors = (String[]) scenario[0];
        String[] shapes = (String[]) scenario[1];
        int maxShapesPerCard = (Integer) scenario[2];

        // Here you would call your generateCards method with the scenario parameters
        LinkedList<String> cards = generateCards(colors, shapes, maxShapesPerCard);
        int expectedAmountOfCards = colors.length * shapes.length * maxShapesPerCard;
        
        if(expectedAmountOfCards != cards.size()) {
          return false;
        }
    }

    return true; // Assuming all scenarios passed after proper validation
}
