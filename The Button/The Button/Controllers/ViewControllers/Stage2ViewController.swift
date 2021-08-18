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
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        hiTimmy()
        
    }
    
    // MARK: - Actions
    
    @IBAction func theButtonTapped(_ sender: Any) {
        
        print("Stage 2 complete")
        
        StageController.shared.currentStage = 3
    }
    
    // MARK: - Helper Methods
    
    func hiTimmy(){
        
        let timmy = UIAlertController(title: "Hi there! My name is Timmy! I'm short on gold...could you spare some stranger?", message: nil, preferredStyle: .alert)
        
        let buzzOffAction = UIAlertAction(title: "Buzz off kid...", style: .cancel) { _ in
            self.buzzOffChoice()
        }
        let giveGoldAction = UIAlertAction(title: "Um...Okay", style: .default) { _ in
            self.goldLabel.text = "Gold: 15"
            self.giveGoldChoice()
            
        }
        
        timmy.addAction(giveGoldAction)
        timmy.addAction(buzzOffAction)
        
        present(timmy, animated: true, completion: nil)
    }
    
    func buzzOffChoice(){
        let timmy = UIAlertController(title: "o...okay...", message: nil, preferredStyle: .alert)
        
        let changeYourMindAction = UIAlertAction(title: "Wait kid, here you go.", style: .default) { _ in
            self.goldLabel.text = "Gold: 15"
            self.giveGoldChoice()
        }
        
        let ignoreTimmyAction = UIAlertAction(title: "Continue with what ever you were doing..", style: .cancel) { _ in
            
        }
        timmy.addAction(changeYourMindAction)
        timmy.addAction(ignoreTimmyAction)
        
        present(timmy, animated: true, completion: nil)
        
    }
    
    func giveGoldChoice(){
        let timmy = UIAlertController(title: "Thank you stranger!", message: nil, preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue with what ever you were doing...", style: .cancel, handler: nil)
        
        timmy.addAction(continueAction)
        
        present(timmy, animated: true, completion: nil)
    }
    
}


