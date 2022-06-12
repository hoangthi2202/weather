//
//  SearchWeatherWireFrame.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import UIKit
import Swinject

protocol SearchWeatherWireFrameProtocol {
}

class SearchWeatherWireFrame {
    func setupWithRootNavVC(_ navVC: UINavigationController) {
        let vc = Assembler.shared.resolver.resolve(SearchWeatherVC.self, argument: self as SearchWeatherWireFrameProtocol)!
        navVC.viewControllers = [vc]
    }
}

extension SearchWeatherWireFrame: SearchWeatherWireFrameProtocol {
}
