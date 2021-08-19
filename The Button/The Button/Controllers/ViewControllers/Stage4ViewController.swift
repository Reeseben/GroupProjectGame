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
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
       addGradient()
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
