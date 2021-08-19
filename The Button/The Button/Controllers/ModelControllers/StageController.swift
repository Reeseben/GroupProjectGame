//
//  StageController.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import Foundation

class StageController{
    
    ///Singleton for The Button game
    static let shared = StageController()
    
    ///SOT
    var stage: Stage = Stage(stageNumber: -1)
    var currentStage = 0
    
    
    //CRUD Functions
    
    func createStage(with stageNumber: Int){
        let newStage = Stage(stageNumber: stageNumber)
        stage = newStage
        
        saveToPersistenceStore()
    }
    
    func updateStage(stageNumber: Int, goldAmount: Int?, newEvents: String? ) {
        
        stage.stageNumber = stageNumber
        if let goldAmount = goldAmount {
            stage.goldAmount = goldAmount
        }
        if let newEvents = newEvents {
            stage.events.append(newEvents)
        }
        
        saveGameState()
    }
    
    func saveGameState(){
        saveToPersistenceStore()
    }
    
    
}


extension StageController{
    
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("The Button.json")
        return fileURL
    }

    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(stage)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }

    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            stage = try JSONDecoder().decode(Stage.self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    
}
}
