// [EVENTS] Track events. Prefix : "Event_{Method name}"

public void addAndDrawButton(int x, int y, int buttonWidth, int buttonHeight, String buttonId, String buttonText) {  
  int[] buttonData = new int[] { x, y, buttonWidth, buttonHeight}; // fromX, toX, width, height
  AddEventBind(buttonId, buttonData); // This will calculate the buttons dimensions for click event validation
  
  drawButton(buttonText, x, y, buttonWidth, buttonHeight, buttonId);
}

// Cords = x, y, width, height (0, 1, 2, 3)
public void AddEventBind(String buttonId, int[] buttonData) {
  int fromX = buttonData[0];
  int toX = buttonData[0] + buttonData[2];
  int fromY = buttonData[1];
  int toY = buttonData[1] + buttonData[3]; 
  
  int[] trackingCords = new int[] { fromX, toX, fromY, toY };
  this.BUTTONS.put(buttonId, trackingCords);
}

public void Event_UserHasValidSet() {
  if(userHasSetSelection()) {
    if(isValidSetSelection()) {
      println("Valid set.. ");
      this.setsFound += 1;
      replaceSelectedCardsWithNewCards();
      clearSelection();
      printSetStatistics();
      addScore();
      this.setsOnTable = countValidSetsInGrid(this.cardPlayfieldGrid); 
    } else {
      println("Not a valid set.. ");
      clearSelection();
    }
  }
}

public void Event_TrackHoveredCard() {
  String hoveredCard = null;
  for(int row = 0; row < this.cardPlayfieldGrid.length; row++) {
    for(int column = 0; column < this.cardPlayfieldGrid[0].length; column++) {
      // See if the mouse is hovered on top of a card in the grid..
      int fromX = column * this.CARDWIDTH;
      int toX = (column + 1) * this.CARDWIDTH;
      int fromY = row * this.CARDHEIGHT;
      int toY = (row + 1) * this.CARDHEIGHT;
           
      if(betweenNums(fromX, toX, mouseX) && betweenNums(fromY, toY, mouseY)) {
        hoveredCard = this.cardPlayfieldGrid[row][column];
      }
    }
  }
  
  this.hoveredCard = hoveredCard;
}

public void Event_TrackGameEnd() {
  // If there's no cards left..
  if(this.setsOnTable == 0) {
    gameActive = false;
    showScoreHomescreen = true;
  }
}

public void Event_TrackCardClicked() {
  if(!strIsNullOrEmpty(this.hoveredCard) && this.selectedCards.size() < 3) {    
    addOrRemoveCardToSelection(this.hoveredCard);
  }
}

public void Event_TrackHoveredButton() {
  String hoveredButton = null;
  
  for (Map.Entry<String, int[]> buttonEntry : this.BUTTONS.entrySet()) {
    String key = buttonEntry.getKey();
    int[] value = buttonEntry.getValue();
    
    if (betweenNums(value[0], value[1], mouseX) && betweenNums(value[2], value[3], mouseY)) {
      hoveredButton = key;
      break; // Stop de lus als we een gehoverde knop hebben gevonden
    }
  };
  
  this.hoveredButton = hoveredButton;
}

public void Event_TrackStartButtonClicked() {
  if(this.hoveredButton == "Button__StartSet") {
    startSet();
  }
}

public void Event_TrackExpandGridButtonClicked() {
  if(this.hoveredButton == "Button__ExpandGrid" && !this.fieldExandUsed) {
    expandGrid();
  }
}
