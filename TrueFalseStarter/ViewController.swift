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
    
    let questionsPerRound = olympicTriviaQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

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
        let triviaQuestion = olympicTriviaQuestions[indexOfSelectedQuestion]
        questionField.text = triviaQuestion.question
        playAgainButton.hidden = true
        
        // Enable Buttons
        
        firstChoiceButton.userInteractionEnabled = true
        secondChoiceButton.userInteractionEnabled = true
        thirdChoiceButton.userInteractionEnabled = true
        fourthChoiceButton.userInteractionEnabled = true
        
        // Display choice text in answer buttons
        
        firstChoiceButton.setTitle(triviaQuestion.firstChoice, forState: .Normal)
        secondChoiceButton.setTitle(triviaQuestion.secondChoice, forState: .Normal)
        thirdChoiceButton.setTitle(triviaQuestion.thirdChoice, forState: .Normal)
        fourthChoiceButton.setTitle(triviaQuestion.fourthChoice, forState: .Normal)
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstChoiceButton.hidden = true
        secondChoiceButton.hidden = true
        thirdChoiceButton.hidden = true
        fourthChoiceButton.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = olympicTriviaQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 3)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
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
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
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
}

