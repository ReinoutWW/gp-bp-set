import java.util.LinkedList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Map;

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
final int INITIAL_GRID_HEIGHT = 3;
final int INITIAL_GRID_WIDTH = 3;

// Settings (Support different sets dynamically)
final int MAX_SHAPES_PER_CARD = 3;
final String[] COLORS = { "red", "green", "blue" };
final String[] SHAPES = { "eclipse", "square", "triangle" };
final int CARD_HEIGHT = 200;
final int CARD_WIDTH = 200;
final int SYMBOL_WIDTH = round(CARD_WIDTH * 0.6f); // Symbol for the card
final int SYMBOL_HEIGHT = round(CARD_HEIGHT * 0.15f); // Symbol for the card
final int CONTROL_BAR_HEIGHT = 150;
final int SET_FOUND_SCORE = 100;
final int MAX_CARD_SELECTION = 3;

// States for the game
String[][] cardPlayfieldGrid = new String[3][3];
LinkedList<String> initialCardDeck = new LinkedList<String>();
LinkedList<String> activeCardDeck = new LinkedList<String>();
LinkedList<String> selectedCards = new LinkedList<String>();

boolean gameActive = false;
boolean showScoreHomescreen = false;
boolean fieldExandUsed = false;
String hoveredCard = null;
String hoveredButton = null;
float userScoreMultiplier = 1f;
int setsOnTable = 0;
int setsFound = 0;
int userScore = 0;

// Styling
PFont FONT_FAMILY;
final int FONT_SIZE = 16;
final int[] COMPONENT_PADDING = new int[] { 10, 10 }; // x, y
HashMap<String, Integer> STYLES = new HashMap<String, Integer>() {{
  put("TextColor", color(20, 20, 20)); 
  put("Card__Background", color(245, 245, 245));
  put("Card__Active", color(249, 239, 219));
  put("Card__Hover", color(245, 242, 235));
  put("Symbol__Red", color(204, 110, 110));
  put("Symbol__Blue", color(110, 144, 204));
  put("Symbol__Green", color(110, 204, 135)); 
  put("ControlBar__Background", color(245, 238, 225)); 
  put("ControlBar__Text", color(20, 20, 20)); 
  put("btn__Text", color(20, 20, 20)); 
  put("btn__FontSize", 12); 
  put("btn__Background", color(235, 208, 176)); 
  put("btn__Hover", color(225, 219, 211)); 
  put("BorderRadius__Element", 10); 
  put("EndScreen__Background", color(245, 238, 225)); 
  put("EndScreen__Text", color(20, 20, 20)); 
  put("Score__Background", color(245, 245, 245)); 
}};

// For event binding
HashMap<String, int[]> BUTTONS = new HashMap<String, int[]>() {{ // Id, Cords, Event click
  put("Button__ExpandGrid", new int[] {0, 0, 0, 0}); // ButtonId + [fromX, toX, fromY, toY]
}};

void setup() {
  this.FONT_FAMILY = createFont("Minecraft.ttf", 128);
  size(600, 600);
  
  StartUnitTest();
}

void draw() {
  // Abstract: Events are used to track certain activity (e.g. addEventListener() method in JavaScript)
  Event_TrackHoveredButton();
  
  if(this.gameActive) {
    sizeWindowToGridAndControlbar(this.cardPlayfieldGrid);
    drawCardsInGrid(this.cardPlayfieldGrid);
    drawControlBar();
  
    Event_TrackHoveredCard();
    Event_UserHasValidSet();
    Event_TrackGameEnd();
  } else {
    drawHomeScreen();
    
    if(this.showScoreHomescreen) {
      drawEndScore();
    }
  }  
}

// [MOUSE] Mouse events
void mousePressed() {
  if(!this.gameActive) {
      Event_TrackStartButtonClicked();
  } else {
      Event_TrackCardClicked();
      Event_TrackExpandGridButtonClicked();
  }
}

public void startSet() {
  println("Starting game..");
  
  this.cardPlayfieldGrid = new String[this.INITIAL_GRID_HEIGHT][this.INITIAL_GRID_WIDTH];
  this.printWindowGridSize(this.cardPlayfieldGrid);
  this.userScore = 0;
  this.userScoreMultiplier = 1f;
  this.setsFound = 0;
  this.fieldExandUsed = false;
  this.gameActive = true;
  this.showScoreHomescreen = false;
  this.hoveredCard = null;
  this.hoveredButton = null;
  this.setsOnTable = 0;
  
  // Setup the playing field
  this.initialCardDeck = generateCards(this.COLORS, this.SHAPES, this.MAX_SHAPES_PER_CARD);
  this.activeCardDeck = new LinkedList<String>(this.initialCardDeck);
  
  // Get the first grid..
  this.fillEmptySlotsWithCards();
  this.setsOnTable = countValidSetsInGrid(this.cardPlayfieldGrid); 

  this.printSetStatistics();
}
