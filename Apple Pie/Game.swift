//
//  Game.swift
//  Apple Pie
//
//  Created by Mindy Douglas on 10/8/20.
//
//  adding code to check out build process

import Foundation

struct Game {
  var word: String
  var incorrectMovesRemaining: Int
  var guessedLetters: [Character]
  
  // computed property that begins with empty string, loops through each character of word.  If character is in guessedLetters, convert to a string and append letter onto variable; otherwise append _ on to variable
  
  var formattedWord: String {
    var guessedWord = ""
    for letter in word {
      if guessedLetters.contains(letter) {
        guessedWord += "\(letter)"
      } else {
        guessedWord += "_"
      }
    }
    return guessedWord
  }
  
  // added a Bool return to use for score
  
  mutating func playerGuessed(letter: Character) -> Bool {
    guessedLetters.append(letter)
    if !word.contains(letter) {
      incorrectMovesRemaining -= 1
      return false
    } else {
      return true
    }
  }
}



