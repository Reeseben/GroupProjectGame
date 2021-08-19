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
    @IBOutlet weak var playerCardImage1: UIImageView!
    @IBOutlet weak var playerCardImage2: UIImageView!
    @IBOutlet weak var playerCardImage3: UIImageView!
    @IBOutlet weak var playerCardImage4: UIImageView!
    @IBOutlet weak var playerCardImage5: UIImageView!
    @IBOutlet var theButton: UIButton!
    
    
    
    
    
    
    // MARK: - Properties
    var playerHand: [Card] = []
    var cardImages: [UIImage] = []
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theButton.layer.cornerRadius = 35
        theButton.layer.masksToBounds = true
        addGradient()
        shuffleDeck()
        drawCard()
        drawCard()
        drawCard()
        drawCard()
    }
    
    override var shouldAutorotate: Bool{
        return false
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
}
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
                    print("Adding \(card.code) to the hand")
                    self.playerHand.append(card)
                    self.fetchImage(with: card.image)
                    
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
                    self.cardImages.append(image)
                    self.self.setImage(for: self.cardImages.count)
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func setImage(for number: Int ){
        
        switch number {
        case 1:
            playerCardImage1.image = cardImages[number-1]
        case 2:
            playerCardImage2.image = cardImages[number-1]
        case 3:
            playerCardImage3.image = cardImages[number-1]
        case 4:
            playerCardImage4.image = cardImages[number-1]
        case 5:
            playerCardImage5.image = cardImages[number-1]
        default:
            return
        }
    }
}
