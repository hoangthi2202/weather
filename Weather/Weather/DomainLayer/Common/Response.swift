//
//  Response.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

enum Response<T> {
    case succeed(T)
    case failed(message: String)
}
