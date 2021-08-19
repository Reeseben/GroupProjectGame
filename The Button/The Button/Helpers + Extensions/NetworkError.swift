//
//  NetworkError.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import Foundation

enum NetworkError: LocalizedError{
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecde
    case noImage
    
    var errorDescription: String?{
        
        switch self {
        
        case .invalidURL:
            return "Unable to reach the server."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server responded with no data"
        case .unableToDecde:
            return "There was an error trying to decode the data."
        case .noImage:
        return "The server responded with no image"
        }
    }
} //End of enum

