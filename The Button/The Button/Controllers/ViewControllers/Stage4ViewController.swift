//
//  Stage4ViewController.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import UIKit

class Stage4ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var backGroundView: UIView!
    @IBOutlet var theButton: UIButton!
    
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var playerCardImage1: UIImageView!
  
    
    // MARK: - Properties
    private var currentCard: Card?
    private var nextCard: Card?
    //var currentGold: Int = StageController.shared.stages[3].goldAmount
   
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theButton.layer.cornerRadius = 35
        theButton.layer.masksToBounds = true
        addGradient()
        //goldLabel.text = "Gold: \(currentGold)"
        //shuffleDeck()
       
        drawCard()
        drawNext()
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    // MARK: - ACTIONS
    @IBAction func highButtonTapped(_ sender: Any) {
        playerCardImage1.isHidden = false
        guard let  currentCard = currentCard else { return }
        print("\(currentCard.code)")
        
        
    }
    @IBAction func lowButtonTapped(_ sender: Any) {
        playerCardImage1.isHidden = false
        guard let  nextCard = nextCard else { return }
        
        print("\(nextCard.code)")
    
    }
    
    
    
    // MARK: - Helper Methods
    func addGradient(){
        let gL = CAGradientLayer()
        
        gL.frame = view.bounds
        gL.colors = [#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1).cgColor, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor ]
        gL.shouldRasterize = true
        
        
        gL.startPoint = CGPoint(x: 0, y: 0)
        gL.endPoint = CGPoint(x: 1, y: 1)
        
        backGroundView.layer.insertSublayer(gL, at: 0)
        
        
    }
}// End of class

//blackjack function
extension Stage4ViewController{
    
    
}// End of extension

//fetch functions
extension Stage4ViewController{
    
    func shuffleDeck(){
        DeckOfCardsController.shuffleDeck { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let success):
                    
                    print(success)
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func drawCard(){
        DeckOfCardsController.drawCard { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let card):
                    
                    self.currentCard = card
                    print("Adding \(card.code) to the hand")
                    
                    //self.playerCardImage1.isHidden = true
                    self.fetchImage(with: card.image)
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    func drawNext(){
        DeckOfCardsController.drawCard { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let card):
                    
                    self.nextCard = card
                    print("Adding \(card.code) to the next hand")
                    
                    //self.playerCardImage1.isHidden = true
                    //self.fetchImage(with: card.image)
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchImage(with url: URL){
        DeckOfCardsController.fetchImage(with: url ) { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let image):
                    self.playerCardImage1.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
}// End of extension
