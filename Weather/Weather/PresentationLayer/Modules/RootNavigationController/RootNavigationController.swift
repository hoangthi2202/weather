//
//  RootNavigationController.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchWeatherWireFrame().setupWithRootNavVC(self)
    }
}
