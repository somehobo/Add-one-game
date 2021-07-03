//
//  ViewController.swift
//  Add 1
//
//  Created by Nolan Brady on 6/1/21.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var userInput: UITextField!
    var playerScore = 0 // this is keeping track of the players score
    var timer:Timer?
    var seconds = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateScore()
        updateNumber()
        updateTimeLabel()
    }
    
    func updateScore(){
        score?.text = String(playerScore)
    }
    
    func updateNumber() {
        number?.text = String.randomNumber(length: 4)
    }

    @IBAction func validate(_ sender: Any) {
        guard let numberText = number?.text, let inputText = userInput?.text else {
            return
        }
        guard inputText.count == 4 else {
            return
        }
        var isCorrect = true
        
        for n in 0..<4 {
            var input = inputText.integer(at: n)
            let number = numberText.integer(at: n)
            
            if input == 0 {
                input = 10
            }
            if input != number+1 {
                isCorrect = false
                break
            }
        }
        if isCorrect {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        updateNumber()
        updateScore()
        userInput?.text = ""
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.seconds == 0 {
                        self.endGame()
                    } else if self.seconds <= 60 {
                        self.seconds -= 1
                        self.updateTimeLabel()
                    }
            }
        }
    }
    
    func updateTimeLabel(){
        let min = (seconds / 60) % 60
        let sec = seconds % 60
        
        time?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    func endGame(){
        timer?.invalidate()
        timer = nil
        let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        playerScore = 0
        seconds = 60
        updateTimeLabel()
        updateScore()
        updateNumber()
    }
    
}

