//
//  ViewController.swift
//  TrueFalseStarter
//
//  Orginally Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
//  Treehouse iOS TechDegree Project 2 - Enhancing a Quiz App in iOS
//  James D. McMillan started 6/27/2016
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // removed the 'magic number' of 4 that was in the starter and replaced with .count to adjust to the amount of questions in the TriviaModel
    let questionsPerRound = olympicTriviaQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var previousQuestionsArray: [Int] = []
    
    // Sound Effects Variables
    
    var gameSound: SystemSoundID = 0
    // global variables for the two additional sound effects
    var gameSoundCorrect: SystemSoundID = 0
    var gameSoundWrong: SystemSoundID = 0
    
    // Lightning Timer Variables
    
    var lightningTimer = NSTimer()
    var seconds = 15
    var timerRunning = false
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(olympicTriviaQuestions.count)
        
        // while loop for making sure that questions are not repeated
        while previousQuestionsArray.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(olympicTriviaQuestions.count)
        }
        
        // appending global previousQuestionsArray varialbe with asked questions so that they are not repeated
        previousQuestionsArray.append(indexOfSelectedQuestion)
        
        let triviaQuestions = olympicTriviaQuestions[indexOfSelectedQuestion]
        questionField.text = triviaQuestions.question
        playAgainButton.hidden = true
        
        
        enableButtons()
        
        // Display choice text in answer buttons
        
        firstChoiceButton.setTitle(triviaQuestions.firstChoice, forState: .Normal)
        secondChoiceButton.setTitle(triviaQuestions.secondChoice, forState: .Normal)
        thirdChoiceButton.setTitle(triviaQuestions.thirdChoice, forState: .Normal)
        fourthChoiceButton.setTitle(triviaQuestions.fourthChoice, forState: .Normal)
        
        resetTimer()
        beginTimer()
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstChoiceButton.hidden = true
        secondChoiceButton.hidden = true
        thirdChoiceButton.hidden = true
        fourthChoiceButton.hidden = true
        timerLabel.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        if correctQuestions == questionsAsked {
            questionField.text = "You've won the GOLD!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
        } else if correctQuestions <= 11 && correctQuestions >= 10 {
            questionField.text = "You've won the SILVER!\n You got \(correctQuestions) out of \(questionsPerRound)"
            
        } else if correctQuestions <= 9 && correctQuestions >= 8 {
            questionField.text = "You've won the BRONZE!\n You got \(correctQuestions) out of \(questionsPerRound)"
            
        } else {
            questionField.text = "Try Again!\n You got \(correctQuestions) out of \(questionsPerRound)"
        }

    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = olympicTriviaQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            disableButtons()
            loadGameSoundCorrect()
            playGameSoundCorrect()
            lightningTimer.invalidate()
        } else {
            questionField.text = "Sorry, wrong answer! \n\n Correct Answer: \(correctAnswer)"
            loadGameSoundWrong()
            playGameSoundWrong()
            disableButtons()
            lightningTimer.invalidate()
        }
        
        loadNextRoundWithDelay(seconds: 3)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            lightningTimer.invalidate()
            resetTimer()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        firstChoiceButton.hidden = false
        secondChoiceButton.hidden = false
        thirdChoiceButton.hidden = false
        fourthChoiceButton.hidden = false
        timerLabel.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        previousQuestionsArray.removeAll()
        playGameStartSound()
        nextRound()
        
    }
    
    // Lightning Timer Methods
    
    func beginTimer() {
        
        if timerRunning == false {
            
            lightningTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.countdownTimer), userInfo: nil, repeats: true)
            
            timerRunning = true
        }
    }
    
    func countdownTimer() {
        
        let selectedQuestionDict = olympicTriviaQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        // countdown by 1 second
        
        seconds -= 1
        
        timerLabel.text = "Seconds Remaining: \(seconds)"
        
        if seconds == 0 {
            
            lightningTimer.invalidate()
            
            questionsAsked += 1
            
            questionField.text = "Sorry, time ran out! \n\n Correct Answer: \(correctAnswer)"
            
            loadGameSoundWrong()
            playGameSoundWrong()
            
            disableButtons()
            
            loadNextRoundWithDelay(seconds: 3)
            
        }
        
    }
    
    func resetTimer() {
        
        seconds = 15
        timerLabel.text = "Seconds Remaining: \(seconds)"
        timerRunning = false
        
    }

    
    // MARK: Helper Methods
    
    // Helper Method to enable and disable the buttons after user has answered a question or began another
    
    func enableButtons() {
        
        firstChoiceButton.userInteractionEnabled = true
        secondChoiceButton.userInteractionEnabled = true
        thirdChoiceButton.userInteractionEnabled = true
        fourthChoiceButton.userInteractionEnabled = true
        
    }
    
    func disableButtons() {
        
        firstChoiceButton.userInteractionEnabled = false
        secondChoiceButton.userInteractionEnabled = false
        thirdChoiceButton.userInteractionEnabled = false
        fourthChoiceButton.userInteractionEnabled = false
        
    }
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
        
    }
    
    
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    // Adding new soundeffects helper methods
    
    func loadGameSoundCorrect() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSoundCorrect", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSoundCorrect)
    }
    
    func playGameSoundCorrect() {
        AudioServicesPlaySystemSound(gameSoundCorrect)
    }
    
    func loadGameSoundWrong() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSoundWrong", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSoundWrong)
    }
    
    func playGameSoundWrong() {
        AudioServicesPlaySystemSound(gameSoundWrong)
    }
}

