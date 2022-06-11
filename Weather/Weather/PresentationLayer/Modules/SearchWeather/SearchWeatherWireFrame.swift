//
//  SearchWeatherWireFrame.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import UIKit

protocol SearchWeatherWireFrameProtocol {
    
}

class SearchWeatherWireFrame {
    private var presentedVC: UIViewController?
    func setupWithPresentedVC(_ pushedVC: UIViewController) {
        presentedVC = pushedVC
    }
}

extension SearchWeatherWireFrame: SearchWeatherWireFrameProtocol {
    
}
