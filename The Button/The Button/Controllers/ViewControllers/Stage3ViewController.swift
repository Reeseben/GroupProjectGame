//
//  Stage3ViewController.swift
//  The Button
//
//  Created by Ben Erekson on 8/18/21.
//

import UIKit

class Stage3ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var theButton: UIButton!
    @IBOutlet var TopLeftButton: UIButton!
    @IBOutlet var TopRightButton: UIButton!
    @IBOutlet var BottomLeftButton: UIButton!
    @IBOutlet var BottomRightButton: UIButton!
    
    //MARK: - Properties
    var CurrentTurn = 0
    var correctPattern: [String] = []
    var isAnimating = false
    var currentAnimation = 0
    var currentGuess = 0
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        theButton.layer.cornerRadius = 35
        theButton.layer.masksToBounds = true
        
        TopLeftButton.layer.cornerRadius = TopLeftButton.layer.bounds.height/2
        TopLeftButton.layer.masksToBounds = true
        
        TopRightButton.layer.cornerRadius = TopRightButton.layer.bounds.height/2
        TopRightButton.layer.masksToBounds = true
        
        BottomRightButton.layer.cornerRadius = BottomRightButton.layer.bounds.height/2
        BottomRightButton.layer.masksToBounds = true
        
        BottomLeftButton.layer.cornerRadius = BottomLeftButton.layer.bounds.height/2
        BottomLeftButton.layer.masksToBounds = true
        
    }
    
    //MARK: - Actions
    @IBAction func theButtonWasTouched(_ sender: Any) {
        if !isAnimating {
            startSimon()
        }
    }
    
    @IBAction func screwWasTapped(_ sender: UIButton) {
        if !isAnimating {
            switch sender {
            case TopLeftButton:
                if correctPattern[currentGuess] == "TL" {
                    print("Correct")
                } else {
                    resetSimon()
                    return
                }
                print("TopLeft")
                
            case TopRightButton:
                if correctPattern[currentGuess] == "TR" {
                    print("Correct")
                } else {
                    resetSimon()
                    return
                }
                print("Top Right")
                
            case BottomLeftButton:
                if correctPattern[currentGuess] == "BL" {
                    print("Correct")
                } else {
                    resetSimon()
                    return
                }
                print("Bottom left")
                
            case BottomRightButton:
                if correctPattern[currentGuess] == "BR" {
                    print("Correct")
                } else {
                    resetSimon()
                    return
                }
                print("bottom right")
                
            default:
                print("You didn't wire a button.")
            }
             if currentGuess == CurrentTurn{
                CurrentTurn += 1
                currentGuess = 0
                print("Current Turn: \(CurrentTurn)")
                showColor(until: CurrentTurn)
            } else {
                currentGuess += 1
            }
        }
    }
    
    //MARK: - Helper Methods
    func startSimon() {
        if correctPattern.count != 5 {
            let options: [String] = ["TL","TR","BL","BR"]
            for _ in 1...5 {
                correctPattern.append(options.randomElement() ?? "TL")
            }
        }
        playSimon()
    }
    
    func playSimon(){
        if CurrentTurn < correctPattern.count {
            showColor(until: CurrentTurn)
        }
    }
    
    func showColor(until index: Int) {
        if CurrentTurn >= correctPattern.count {
            print("Moving to next stage!")
            self.transitionToNewController(stageName: "Stage4", identifier: "Stage4ViewController")
            return
        }
        if currentAnimation <= index {
            isAnimating = true
            let button = correctPattern[currentAnimation]
            switch button {
            case "TL":
                UIView.animate(withDuration: 0.3, delay: 0.5, options: [.autoreverse], animations: {
                    self.TopLeftButton.backgroundColor = .green
                }) { _ in
                    self.TopLeftButton.backgroundColor = nil
                    self.showColor(until: self.CurrentTurn)
                }
            case "TR" :
                UIView.animate(withDuration: 0.3, delay: 0.5, options: [.autoreverse], animations: {
                    self.TopRightButton.backgroundColor = .red
                }) { _ in
                    self.TopRightButton.backgroundColor = nil
                    self.showColor(until: self.CurrentTurn)
                }
            case "BL" :
                UIView.animate(withDuration: 0.3, delay: 0.5, options: [.autoreverse], animations: {
                    self.BottomLeftButton.backgroundColor = .blue
                }) { _ in
                    self.BottomLeftButton.backgroundColor = nil
                    self.showColor(until: self.CurrentTurn)
                }
            case "BR" :
                UIView.animate(withDuration: 0.3, delay: 0.5, options: [.autoreverse], animations: {
                    self.BottomRightButton.backgroundColor = .yellow
                }) { _ in
                    self.BottomRightButton.backgroundColor = nil
                    self.showColor(until: self.CurrentTurn)
                }
            default:
                print("You missed one.")
            }
            currentAnimation += 1
            print("Current Animation: \(currentAnimation)")
        } else {
            print("Done!")
            isAnimating = false
            currentAnimation = 0
        }
        
    }
    
    func resetSimon(){
        correctPattern.removeAll()
        CurrentTurn = 0
        currentGuess = 0
        currentAnimation = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: [.autoreverse], animations: {
            self.TopRightButton.backgroundColor = .red
            self.TopLeftButton.backgroundColor = .red
            self.BottomRightButton.backgroundColor = .red
            self.BottomLeftButton.backgroundColor = .red
        }) { _ in
            self.TopRightButton.backgroundColor = nil
            self.TopLeftButton.backgroundColor = nil
            self.BottomRightButton.backgroundColor = nil
            self.BottomLeftButton.backgroundColor = nil
            self.startSimon()
        }
    }
    
}
