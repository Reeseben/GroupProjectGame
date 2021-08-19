//
//  ViewController.swift
//  The Button
//
//  Created by Ben Erekson on 8/18/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var theButton: UIButton!
    
    //MARK: - Properties
    let backgroundColors: [UIColor] = [#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)]
    var currentColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        StageController.shared.loadFromPersistenceStore()
        
        theButton.isHidden = true
        
        theButton.layer.cornerRadius = 35
        theButton.layer.masksToBounds = true
        
    }
    //Used for testing specific stages
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkStage()
    }
    
    //MARK: - Properties
    @IBAction func theButtonWasTapped(_ sender: Any) {
        
        //Assigns a random color from the above list to what will become the background view
        let newColor = backgroundColors.randomElement()
        guard var newColor = newColor else { return }
        
        //check to make sure it didn't assign the same color as the background again.
            if newColor == currentColor {
                guard let index = backgroundColors.firstIndex(of: newColor) else { return }
                
                //if the current color is the last element in the array and it tried to assign it as that color again progress the game
                if index == backgroundColors.count - 1{
                    newColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    print("Stage 1 complete")
                    StageController.shared.updateStage(stageNumber: 1, goldAmount: nil, newEvents: nil)
                    exit(0)
                } else {
                    newColor = backgroundColors[index + 1]
                }
            }
        //Store the color that is the background currently then set it to the background
        currentColor = newColor
        view.backgroundColor = newColor
    }
    
    //MARK: - Helper Methods
    func checkStage(){
        let stageNumber = StageController.shared.stage.stageNumber
        
        switch stageNumber {
        case -1:
            print("New Player Detected.")
            StageController.shared.createStage(with: 0)
            theButton.isHidden = false
        case 0:
            theButton.isHidden = false
            return
        case 1:
            transitionToNewController(stageName: "Stage2", identifier: "Stage2ViewController")
        case 2:
            transitionToNewController(stageName: "Stage3", identifier: "Stage3ViewController")
        case 3:
            transitionToNewController(stageName: "Stage4", identifier: "Stage4ViewController")
        case 4 :
            transitionToNewController(stageName: "JudgementHall", identifier: "JudgementHall")
        default:
            print("Honestly I don't know why this ran.")
        }
    }
}



