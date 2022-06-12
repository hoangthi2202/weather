//
//  RepositoryError.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

enum RepositoryError: Error {
    case unknown(message: String)
    case notFound
    case urlNotCorrect
    
    func message() -> String {
        switch self {
        case .unknown(message: let messge): return messge
        default: return self.localizedDescription
        }
    }
}
