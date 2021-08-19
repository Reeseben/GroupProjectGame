//
//  Stage2ViewController.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import UIKit

class Stage2ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var goldLabel: UILabel!
    
    // MARK: - Properties
    var gold = StageController.shared.stage.goldAmount
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        theButton.layer.cornerRadius = 35
        theButton.layer.masksToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if gold <= 25 {
            hiTimmy()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func theButtonTapped(_ sender: Any) {
        StageController.shared.updateStage(stageNumber: 2, goldAmount: gold, newEvents: nil)
        exit(0)
    }
    
    // MARK: - Helper Methods
    
    func hiTimmy(){
        
        let timmy = UIAlertController(title: "Hi there! My name is Timmy! I'm short on gold...could you spare some stranger?", message: "Do you give Timmy some gold?", preferredStyle: .alert)
        
        let buzzOffAction = UIAlertAction(title: "Tell Timmy to buzz off!", style: .default) { _ in
            DispatchQueue.main.async {
                
                self.buzzOffChoice()
            }
        }
        let giveGoldAction = UIAlertAction(title: "Give Timmy gold", style: .default) { _ in
            self.gold -= 10
            StageController.shared.updateStage(stageNumber: 1, goldAmount: self.gold, newEvents: EventConstants.gaveTimmyGold)
            self.goldLabel.text = "Gold: \(self.gold)"
            self.giveGoldChoice()
        }
        
        timmy.addAction(giveGoldAction)
        timmy.addAction(buzzOffAction)
        
        present(timmy, animated: true, completion: nil)
    }
    
    func buzzOffChoice(){
        let timmy = UIAlertController(title: "Oh...okay...", message: "Saddened, the voice begins to fade.", preferredStyle: .alert)
        
        let changeYourMindAction = UIAlertAction(title: "\"Wait kid, here you go.\"", style: .default) { _ in
            self.gold -= 10
            StageController.shared.updateStage(stageNumber: 1, goldAmount: self.gold, newEvents: EventConstants.hesitatedGold)
            self.goldLabel.text = "Gold: \(self.gold)"
            self.giveGoldChoice()
        }
        
        let ignoreTimmyAction = UIAlertAction(title: "Continue with what ever you were doing..", style: .default) { _ in
            
        }
        timmy.addAction(changeYourMindAction)
        timmy.addAction(ignoreTimmyAction)
        
        present(timmy, animated: true, completion: nil)
        
    }
    
    func giveGoldChoice(){
        let timmy = UIAlertController(title: "Thank you stranger!", message: "The strange voice, ever so happy, fades away...", preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue with what ever you were doing", style: .cancel, handler: nil)
        
        timmy.addAction(continueAction)
        
        present(timmy, animated: true, completion: nil)
    }
    
}


