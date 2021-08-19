//
//  DeckofCardsController.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import UIKit

class DeckOfCardsController{
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/oa2tckpaep9z/")
    
    static let drawComponent = "draw"
    static let shuffleComponent = "shuffle"
    static let pileComponent = "pile"
    
    static func shuffleDeck(completion: @escaping() -> Void){
        
        guard let baseURL = baseURL else { return completion()}
        let finalURL = baseURL.appendingPathComponent(shuffleComponent)
        print(finalURL)
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion())
            }
            guard let data = data else { return completion()}
            
            do{
                let _ = try JSONDecoder().decode(Shuffled.self, from: data)
               // let success = shuffled.shuffled
                completion()
            }catch{
                completion()
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        task.resume()
    }
    
    static func drawCard(completion: @escaping(Result<Card, NetworkError>) -> Void){
        guard let baseURL = baseURL else { return }
        let finalURL = baseURL.appendingPathComponent(drawComponent)
        print(finalURL)
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(.thrownError(error))))
            }
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let TLO = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let card = TLO.cards[0]
                completion(.success(card))
            }catch{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
        }
        task.resume()
    }
    
    static func fetchImage(with url: URL, completion: @escaping(Result<UIImage, NetworkError>) -> Void){
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(.thrownError(error))))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else { return completion(.failure(.noImage))}
            completion(.success(image))
            
        }
        task.resume()
    }
}
