import java.util.LinkedList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Arrays;
import java.util.Map;

// Seperate UnitTest logic to prevent starting with issues.
boolean unitTestSuccess = false;

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
final int SET_FOUND_SCORE = 100;
final int MAX_CARD_SELECTION = 3;

boolean gameActive = false;
boolean showScoreHomescreen = false;
boolean fieldExandUsed = false;
String hoveredCard = null;
String hoveredButton = null;
float userScoreMultiplier = 1f;
int setsOnTable = 0;
int setsFound = 0;
int userScore = 0;

void setup() {
  this.FONT_FAMILY = createFont("Minecraft.ttf", 128);
  size(600, 600);
  
  try {
    unitTestSuccess = startUnitTest();
  } catch (Exception e) {
    e.printStackTrace();
    unitTestSuccess = false;
  }
}

void draw() {
  if(unitTestSuccess) {
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
