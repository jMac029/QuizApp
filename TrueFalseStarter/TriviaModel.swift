//
//  TriviaModel.swift
//  QuizApp
//
//  Created by James McMillan on 6/28/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//


// declarring a class containing the data set for the trivia questions and answers
// thirdChoice and fourthChoice are optionals as they will be part of True/False questions

class Trivia {
    
    let question: String
    let firstChoice: String
    let secondChoice: String
    let thirdChoice: String
    let fourthChoice: String
    let correctAnswer: String
    
    init(question: String, firstChoice: String, secondChoice: String, thirdChoice: String, fourthChoice: String, correctAnswer: String) {
        self.question = question
        self.firstChoice = firstChoice
        self.secondChoice = secondChoice
        self.thirdChoice = thirdChoice
        self.fourthChoice = fourthChoice
        self.correctAnswer = correctAnswer
        
    }
}

// trivia questions with answer choices and correctAnswer declared

let triviaQuestion01 = Trivia(question: "In which city were the first Modern Olympics held",
                              firstChoice: "Munich",
                              secondChoice: "Paris",
                              thirdChoice: "Geneva",
                              fourthChoice: "Athens",
                              correctAnswer: "Athens")

let triviaQuestion02 = Trivia(question: "In which year were the first Modern Olympics held",
                              firstChoice: "1888",
                              secondChoice: "1896",
                              thirdChoice: "1900",
                              fourthChoice: "1908",
                              correctAnswer: "1896")

let triviaQuestion03 = Trivia(question: "What is the meaning of the Olympic Motto, 'Citius, Altius, Fortius.'",
                              firstChoice: "Citidel, Attitude, Fortitude",
                              secondChoice: "Faster, Higher, Stronger",
                              thirdChoice: "Civility, Attainment, Fortune",
                              fourthChoice: "Quicker, Heavier, Taller",
                              correctAnswer: "Faster, Higher, Stronger")

let triviaQuestion04 = Trivia(question: "Which city last hosted the Summer Games in North America held?",
                              firstChoice: "Los Angeles",
                              secondChoice: "Atlanta",
                              thirdChoice: "Salt Lake City",
                              fourthChoice: "New York City",
                              correctAnswer: "Atlanta")

let triviaQuestion05 = Trivia(question: "Golf returns to the olympics in 2016, what year was it last played?",
                              firstChoice: "1904",
                              secondChoice: "1924",
                              thirdChoice: "1896",
                              fourthChoice: "1948",
                              correctAnswer: "1904")

let triviaQuestion06 = Trivia(question: "What was the last year that Tug-of-War was an olympic sport?",
                              firstChoice: "1996",
                              secondChoice: "2000",
                              thirdChoice: "1900",
                              fourthChoice: "1920",
                              correctAnswer: "1920")

let triviaQuestion07 = Trivia(question: "How many events are in the Decathlon?",
                              firstChoice: "5",
                              secondChoice: "7",
                              thirdChoice: "10",
                              fourthChoice: "8",
                              correctAnswer: "10")

let triviaQuestion08 = Trivia(question: "Michael Phelps holds the most medals ever won, how many is it?",
                              firstChoice: "22",
                              secondChoice: "33",
                              thirdChoice: "25",
                              fourthChoice: "18",
                              correctAnswer: "22")

let triviaQuestion09 = Trivia(question: "The Summer Games in 2020 are to be held in which city?",
                              firstChoice: "Los Angeles",
                              secondChoice: "Paris",
                              thirdChoice: "Tokyo",
                              fourthChoice: "Moscow",
                              correctAnswer: "Tokyo")

let triviaQuestion10 = Trivia(question: "What is the only Olympic sport in which men and women compete against each other?",
                              firstChoice: "Tennis",
                              secondChoice: "Basketball",
                              thirdChoice: "Field Hockey",
                              fourthChoice: "Equestrian",
                              correctAnswer: "Equestrian")

let triviaQuestion11 = Trivia(question: "What Olympic Sport has the USA never won a medal in?",
                              firstChoice: "Badminton",
                              secondChoice: "Field Hockey",
                              thirdChoice: "Table Tennis",
                              fourthChoice: "Handball",
                              correctAnswer: "Badminton")

let triviaQuestion12 = Trivia(question: "When was the first Olympic torch relay held?",
                              firstChoice: "1896",
                              secondChoice: "1948",
                              thirdChoice: "1920",
                              fourthChoice: "1936",
                              correctAnswer: "1936")

let olympicTriviaQuestions = [triviaQuestion01,
                              triviaQuestion02,
                              triviaQuestion03,
                              triviaQuestion04,
                              triviaQuestion05,
                              triviaQuestion06,
                              triviaQuestion07,
                              triviaQuestion08,
                              triviaQuestion09,
                              triviaQuestion10,
                              triviaQuestion11,
                              triviaQuestion12
]
