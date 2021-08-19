//
//  Extensions.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import UIKit

extension UIView{
    
    struct goldLabelSpacingConstants {
        static let outerTopPadding: CGFloat = 28.0
        static let outerLeadingPadding: CGFloat = 40.0
    }
    
    
    
}

extension UIViewController{
    
    ///This function is for testing purposes. It allows us to jump directly to any given stage.
    func transitionToNewController(stageName: String, identifier: String){
        let storyboard = UIStoryboard(name: stageName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: identifier)
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
}


