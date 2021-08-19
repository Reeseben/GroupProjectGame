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
    @IBOutlet weak var playerCardImage2: UIImageView!
    
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    
    
    
    // MARK: - Properties
    private var currentCard: Card?
    private var nextCard: Card?
    private var play: Int = 0
    private var wins: Int = 0
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
        
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    // MARK: - ACTIONS
    @IBAction func highButtonTapped(_ sender: Any) {
        play += 1
        
        lowButton.isHidden = true
        playerCardImage2.isHidden = false
     
        guard let currentCard = currentCard else { return }
        guard let nextCard = nextCard else { return }
        
        guard let current = dict[currentCard.value] else { return }
        guard let next = dict[nextCard.value] else { return }
        
        if current < next {
            print("You win")
            wins += 1
        } else if current > next {
            print("You loose")
            
        }else{
            print("Tie game stranger. House always wins...")
            
        }
    }
    
    @IBAction func lowButtonTapped(_ sender: Any) {
        play += 1
        
        highButton.isHidden = true
        playerCardImage2.isHidden = false
        guard let  currentCard = currentCard else { return }
        guard let nextCard = nextCard else { return }
      
        guard let current = dict[currentCard.value] else { return }
        guard let next = dict[nextCard.value] else { return }
        
        if current > next {
            print("You win")
            wins += 1
            
        } else if current < next {
            print("You loose")
            
        }else{
            print("Tie game stranger. House always wins...")
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        reset()
        drawNext()
        lowButton.isHidden = false
        highButton.isHidden = false
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
    
    let dict: [String : Int] = [
        
        "ACE" : 1,
        "2" : 2,
        "3" : 3,
        "4" : 4,
        "5" : 5,
        "6" : 6,
        "7" : 7,
        "8" : 8,
        "9" : 9,
        "0" : 10,
        "JACK" : 11,
        "QUEEN" : 12,
        "KING" : 13
    ]
    
    
}// End of class

//blackjack function
extension Stage4ViewController{
    func reset(){
        shuffleDeck()
        
        playerCardImage1.image = playerCardImage2.image
        playerCardImage2.isHidden = true
        
    }
    
}// End of extension

//fetch functions
extension Stage4ViewController{
    
    func shuffleDeck(){
        DeckOfCardsController.shuffleDeck {
            print("we think we shuffled")
        }
    }
    
    func drawCard(){
        DeckOfCardsController.drawCard { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let card):
                    
                    self.currentCard = card
                    print("Adding \(card.code) to the hand")
                    
                    self.drawNext()
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
                    
                self.playerCardImage2.isHidden = true
                self.fetchImage2(with: card.image)
                
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchImage2(with url: URL){
        DeckOfCardsController.fetchImage(with: url ) { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let image):
                    self.playerCardImage2.image = image
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

