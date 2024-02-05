import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.LinkedList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Map;

final Pattern cardSymbolPattern = Pattern.compile("\\d[A-Za-z]{2}", Pattern.CASE_INSENSITIVE);

// -- Space and time complexity --
// For some methods, the space and time complexity has been given in big O. e.g. o(n).

// -- Naming conventions --
// cardSymbol means the name for the cards. "3rs" = 3 red squares
// the term Grid or Playfield are used to build or manage the playfield. Assume there terms mean the same.

// -- Solution algorithm --
// String[][] cardPlayfieldGrid is leading. Once this grid changes, the visuals will change with it.
// Selection of cards will be done using the selectedCards list. Once 3 items are in the list, it will automatically validate
// if there's a correct set. 

// -- Configuration --
// Possible configurations:
// - Change grid size, e.g. 3x4
// - Change colors. e.g. new color rgb values.
// - Card sizing (width and height)
// - Symbol sizing (width and height)

// Playing field (Dynamic playing field)
String[][] cardPlayfieldGrid = new String[3][3];

// Settings (Support different sets dynamically)
final String[] COLORS = { "red", "green", "blue" };
final String[] SHAPES = { "eclipse", "square", "triangle" };
final int MAXSHAPESPERCARD = 3;

// Card dimensions
final int CARDHEIGHT = 200;
final int CARDWIDTH = 200;
final int SYMBOLWIDTH = round(CARDWIDTH * 0.7f); // Symbol for the card
final int SYMBOLHEIGHT = round(CARDHEIGHT * 0.10f); // Symbol for the card
final int[] COMPONENTPADDING = new int[] { 10, 10 }; // x, y
final int FONTSIZE = 16;
final int CONTROLBARHEIGHT = 150;

int CONTROLBARWIDTH = this.cardPlayfieldGrid[0].length * CARDWIDTH;

// States for the game
LinkedList<String> initialCardDeck = new LinkedList<String>();
LinkedList<String> activeCardDeck = new LinkedList<String>();
LinkedList<String> selectedCards = new LinkedList<String>();
String hoveredCard = null;
String hoveredButton = null;
int setsOnTable = 0;
int setsFound = 0;
boolean gameActive = true;

// Styling
HashMap<String, Integer> STYLES = new HashMap<String, Integer>() {{
  put("CardBackground", color(245, 245, 245));
  put("CardBackground__Active", color(249, 239, 219));
  put("CardBackground__Hover", color(245, 238, 225));
  put("Symbol__Red", color(204, 110, 110));
  put("Symbol__Blue", color(110, 144, 204));
  put("Symbol__Green", color(110, 204, 135)); 
  put("ControlBarBackground", color(245, 238, 225)); 
  put("ControlBarText", color(20, 20, 20)); 
  put("ControlBarButton", color(20, 20, 20)); 
  put("ControlBarButton__Hover", color(50, 50, 50)); 
  put("BorderRadius__Element", 10); 
}};

HashMap<String, int[]> BUTTONS = new HashMap<String, int[]>() {{
  put("Button__ExpandGrid", new int[] {0, 0, 0, 0}); // ButtonId + [fromX, toX, fromY, toY]
}};

void setup() {
  size(600, 600);
  
  println("Starting game..");
  printWindowGridSize(this.cardPlayfieldGrid);

  // Setup the playing field
  this.initialCardDeck = generateCards(this.COLORS, this.SHAPES, this.MAXSHAPESPERCARD);
  this.activeCardDeck = new LinkedList<String>(this.initialCardDeck);
  
  // Get the first grid..
  fillEmptySlotsWithCards();
  this.setsOnTable = countValidSetsInGrid(this.cardPlayfieldGrid); 

  printSetStatistics();
}

void draw() {
  sizeWindowToGridAndControlbar(this.cardPlayfieldGrid);
  drawCardsInGrid(this.cardPlayfieldGrid);
  drawControlBar();
  
  // Abstract: Events are used to track certain activity (e.g. addEventListener() method in JavaScript)
  Event_TrackHoveredCard();
  Event_TrackHoveredButton();
  Event_UserHasValidSet();
  Event_TrackGameEnd();
}

// [MOUSE] Mouse events
void mousePressed() {
  Event_TrackCardClicked();
  Event_TrackButtonClicked();
}

void clearSelection() {
  this.selectedCards = new LinkedList<String>();
}

public boolean userHasSetSelection() {
  return (this.selectedCards.size() == 3);
}

public boolean cardIsInSelection(String card) {
  return this.selectedCards.contains(card);
}

public boolean isValidSetSelection() {
    return isValidSet(this.selectedCards.get(0), this.selectedCards.get(1), this.selectedCards.get(2));
}

public void addOrRemoveCardToSelection(String card) {
  if(this.selectedCards.contains(card)) {
    this.selectedCards.remove(card);
  } else {
    this.selectedCards.add(card);
  }
}



// [VALIDATE] Validating sets
private static boolean isValidSet(String card1, String card2, String card3) {
    if(strIsNullOrEmpty(card1) || strIsNullOrEmpty(card2) || strIsNullOrEmpty(card3)) {
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

// [DECK] Deck management methods
public String[][] addCardsToEmptyCardDeckSlots(String[][] cardsGrid, LinkedList<String> cards) {
  if(cards.size() != countEmptyCardsInGrid(cardsGrid)) {
     return new String[][]{};
  };
  
  println("Adding cards to empty grid..");
  for(int rowI = 0; rowI < cardsGrid.length; rowI++) {
    for(int columnI = 0; columnI < cardsGrid[rowI].length; columnI++) {
      if(strIsNullOrEmpty(cardsGrid[rowI][columnI])) {
        cardsGrid[rowI][columnI] = cards.pop();
      }
    }
  }
  
  return cardsGrid;
}

public LinkedList<String> generateCards(String[] colors, String[] shapes, int maxShapesPerCard) {
  print("Generating cards using predefined settings..");
  LinkedList<String> cards = new LinkedList<String>();
  
  for(int colorI = 0; colorI < colors.length; colorI++) {
     for(int shapeI = 0; shapeI < shapes.length; shapeI++) { 
       for(int maxShapesI = 0; maxShapesI < maxShapesPerCard; maxShapesI++) { 
          String colorSymbol = colors[colorI].substring(0, 1);
          String shapeSymbol = shapes[shapeI].substring(0, 1);
          String shapeAmount = str(maxShapesI + 1);
          
          String card = shapeAmount + colorSymbol + shapeSymbol;
          cards.add(card);
       }
     }
  }
  
  return cards;
};

void replaceSelectedCardsWithNewCards() {
  for(int row = 0; row < this.cardPlayfieldGrid.length; row++) {
    for(int column = 0; column < this.cardPlayfieldGrid[0].length; column++) {
      String card = this.cardPlayfieldGrid[row][column];
      String newCard = "";
      
      if(cardIsInSelection(card)) {
        this.activeCardDeck.remove(card);
        LinkedList<String> newCards = getRandomCardsFromActiveDeck(1);
        
        if(newCards.size() != 0) {
          newCard = newCards.get(0);
        }
        
        this.cardPlayfieldGrid[row][column] = newCard;
      }
    }
  }
}
