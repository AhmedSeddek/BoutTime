//
//  ViewController.swift
//  BoutTime
//
//  Created by ahmed seddek on 8/21/16.
//  Copyright © 2016 ahmed seddek. All rights reserved.
//

import UIKit
import AudioToolbox


enum GameState {
    case Pregame
    case PlayingRound
    case FinishedRound
    case FinishedGame
}



class ViewController: UIViewController {
    
    var timer = NSTimer() // Timer for countdown
    let numberOfRounds = 6 // This is the number of rounds to complete before getting a final score
    let correctButonImage = UIImage(named: "next_round_success")
    let failedButtonImage = UIImage(named: "next_round_fail")
    
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    
    var events = Events() // Instance of Events
    var currentRound = 1
    var score = 0
    var gamestate = GameState.Pregame
    var timeRemaining = 30 // Set time per round.
    
    

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var roundAndScoreLabel: UILabel!
    @IBOutlet weak var firstArrow: UIButton!
    @IBOutlet weak var secondArrow: UIButton!
    @IBOutlet weak var thirdArrow: UIButton!
    @IBOutlet weak var fourthArrow: UIButton!
    @IBOutlet weak var fifthArrow: UIButton!
    @IBOutlet weak var sixthArrow: UIButton!
    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    @IBAction func pressedplayAgain(sender: AnyObject) {
        countdownLabel.hidden = true
        firstView.hidden = true
        secondView.hidden = true
        thirdView.hidden = true
        fourthView.hidden = true
        nextRoundButton.hidden = true
        roundAndScoreLabel.hidden = true
        startGameButton.hidden = false
    }
    
    func finalHidden() {
        firstView.hidden = true
        secondView.hidden = true
        thirdView.hidden = true
        fourthView.hidden = true
        nextRoundButton.hidden = true
        roundAndScoreLabel.hidden = true
        finalScore.hidden = false
        scoreLabel()
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playWrongSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
    
    func loadSounds() {
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("CorrectDing", ofType: "wav")!), &correctSound)
        
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("IncorrectBuzz", ofType: "wav")!), &wrongSound)
    }
    
    func checkAnswers() {
        if (events.orderIsCorrect()) {
            score += 1
            nextRoundButton.setBackgroundImage(correctButonImage, forState: .Normal)
            playCorrectSound()
        } else {
            nextRoundButton.setBackgroundImage(failedButtonImage, forState: .Normal)
            playWrongSound()
        }
    }
    
    func update() {
        switch gamestate {
        case .Pregame:
            setupUI()
            playAgain.hidden = true
            finalScore.hidden = true
        case .PlayingRound:
            enablebuttons()
            playAgain.hidden = true
            finalScore.hidden = true
            updateScoreLabel()
            setupUI()
            if(timeRemaining > 0) {
                timeRemaining -= 1
                countdownLabel.text = "\(timeRemaining) seconds remaining or shake device to check answers"
            } else {
                timer.invalidate()
                gamestate = .FinishedRound
                update()
            }
        case .FinishedRound:
            disableButtons()
            checkAnswers()
            setupUI()
            timer.invalidate()
            timeRemaining = 30
            updateScoreLabel()
            if (currentRound == 6) {
                gamestate = .FinishedGame
                update()
            } else {
                currentRound += 1
            }
        case .FinishedGame:
            finalHidden()
            playAgain.hidden = false
            disableButtons()
            scoreLabel()
            score = 0
            currentRound = 1
        }
    }
    
    func scoreLabel() {
    finalScore.hidden = false
    finalScore.text = "your score: \(score)"
    }
    //using in every round end
    func disableButtons() {
        firstArrow.enabled = false
        secondArrow.enabled = false
        secondArrow.enabled = false
        thirdArrow.enabled = false
        fourthArrow.enabled = false
        fifthArrow.enabled = false
        sixthArrow.enabled = false
        nextRoundButton.hidden = true
    }
    //using in every round end
    func enablebuttons() {
        firstArrow.enabled = true
        secondArrow.enabled = true
        secondArrow.enabled = true
        thirdArrow.enabled = true
        fourthArrow.enabled = true
        fifthArrow.enabled = true
        sixthArrow.enabled = true
        nextRoundButton.hidden = false
    }
    
    func getNewRound() {
        events = Events()
        updateLabels()
        gamestate = .PlayingRound
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
    }
    
    func updateLabels() {
        firstLabel.text = events.questions[0]["Title"] as? String
        secondLabel.text = events.questions[1]["Title"] as? String
        thirdLabel.text = events.questions[2]["Title"] as? String
        fourthLabel.text = events.questions[3]["Title"] as? String
    }
    
    func updateScoreLabel() {
        roundAndScoreLabel.text = "round \(currentRound)/6, score \(score)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
        gamestate = .FinishedRound
            update()
        }
    }
    
    @IBAction func pressedStartGame(sender: AnyObject) {
        getNewRound()
        update()
    }
    @IBAction func pressedNextRound(sender: AnyObject) {
        getNewRound()
        update()
    }
    
    // using buttons tags to use same code for all arrows buttons and different actions through switch cases
    @IBAction func pressedReorderButton(sender: UIButton) {
        switch sender.tag {
        case 0, 1: events.swapElements(0, toIndex: 1)
        case 2, 3: events.swapElements(1, toIndex: 2)
        case 4, 5: events.swapElements(2, toIndex: 3)
        default: print("\(sender.tag) not recognized")
        }
        updateLabels()
    }
    
    func setupUI() {
        firstView.layer.cornerRadius = 5
        secondView.layer.cornerRadius = 5
        thirdView.layer.cornerRadius = 5
        fourthView.layer.cornerRadius = 5
    
        // Switch on gamestate and change visibility of UI elements based on current status
        switch gamestate {
        
        case .Pregame:
            firstView.hidden = true
            secondView.hidden = true
            thirdView.hidden = true
            fourthView.hidden = true
            
            nextRoundButton.hidden = true
            startGameButton.hidden = false
            countdownLabel.hidden = true
            roundAndScoreLabel.hidden = true
            
        case .PlayingRound:
            firstView.hidden = false
            secondView.hidden = false
            thirdView.hidden = false
            fourthView.hidden = false
            
            nextRoundButton.hidden = true
            startGameButton.hidden = true
            countdownLabel.hidden = false
            roundAndScoreLabel.hidden = false
            
        case .FinishedRound:
            nextRoundButton.hidden = false
            countdownLabel.hidden = true
        default: break
        }
    }
}

