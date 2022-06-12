//
//  SearchWeatherVC.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import UIKit

protocol SearchWeatherViewProtocol: AnyObject {
    
}

class SearchWeatherVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchWeatherPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension SearchWeatherVC: SearchWeatherViewProtocol {
    
}
