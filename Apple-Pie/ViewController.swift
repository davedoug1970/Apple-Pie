//
//  ViewController.swift
//  Apple Pie
//
//  Created by Mindy Douglas on 10/7/20.
//

import UIKit

class ViewController: UIViewController {
  
  var listOfWords = ["mother", "truck", "lobster", "raincoat", "sunflower", "dragon", "sandwich", "submarine"]
  
  var totalScore = 0  // added to keep score
  
  let incorrectMovesAllowed = 7
  
  // didSet property observers
  var totalWins = 0 {
    didSet {
      newRound()
      totalScore += 2
    }
    
  }
  var totalLosses = 0 {
    didSet {
      newRound()
    }
  }
  
  @IBOutlet weak var treeImageView: UIImageView!
  @IBOutlet weak var correctWordLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet var letterButtons: [UIButton]!
  @IBOutlet weak var newScoreLabel: UILabel!
  
  
  @IBAction func buttonPressed(_ sender: UIButton) {
    sender.isEnabled = false // disables buttons once pressed
    //read the letter that the player pressed, determine if it's in the word
    let letterString = sender.title(for: .normal)!
    let letter = Character(letterString.lowercased())
    
    // currentGame.playerGuessed(letter: letter)
    
    if currentGame.playerGuessed(letter: letter) == true {
      totalScore += 1
    }
    
    updateGameState()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newRound()
  }
  
  var currentGame: Game!  // instance of game struct
  
  func newRound() {
    // give game a new word in initializer by removing the first value from the collection
    // if listOfWords isn't empty, re-enable all fo the buttons
    // disable buttons when there are no more words
    
    if !listOfWords.isEmpty {
      
      let newWord = listOfWords.removeFirst()
      
      //set incorrectMovesRemaining to thenumber of moves you allow, stored in incorrectMovesAllowed
      
      currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
      
      enableLetterButtons(true)
      updateUI()
    } else {
      enableLetterButtons(false)
    }
  }
  
  func enableLetterButtons(_ enable: Bool) {
    for button in letterButtons {
      button.isEnabled = enable
    }
  }
  
  //UpdateUI handles interface updates - call at end of first round
  
  func updateUI() {
    // formattedWord is the computed property from Game struct
    
    // convert array of characters in formattedWord into an array of strings. Use a loop to store each new string into an array and call joined(separator:) method to join the new collection together separated by blank spaces
    
    var letters = [String]()
    for letter in currentGame.formattedWord {
      letters.append(String(letter))
    }
    
    // map method
    // let letters = Array(currentGame.formattedWord).map { String($0) }
    
    let wordWithSpacing = letters.joined(separator: " ")
    
    correctWordLabel.text  = wordWithSpacing
    
    
    scoreLabel.text = "Wins:   \(totalWins)   Losses:   \(totalLosses)"
    newScoreLabel.text = "Score: \(totalScore)"
    
    treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
  }
  
  // function increments totalLosses and begins new round when incorrectMovesRemaining reaches 0.  Also checks game state to update totalWins and totalLosses
  
  func updateGameState() {
    
    if currentGame.incorrectMovesRemaining == 0 {
      totalLosses += 1
    } else if currentGame.word == currentGame.formattedWord {
      totalWins += 1
      updateUI()
    } else {
      updateUI()
    }
  }
}

