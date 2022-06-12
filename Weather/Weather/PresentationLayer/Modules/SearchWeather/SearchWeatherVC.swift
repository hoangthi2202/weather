//
//  SearchWeatherVC.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import UIKit
import Combine

protocol SearchWeatherViewProtocol: AnyObject {
    func updateUIWithData(_ data: DomainCity)
    func showErrorMessage(_ message: String)
}

class SearchWeatherVC: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @Published var searchingText: String = ""
    var presenter: SearchWeatherPresenterProtocol?
    private var dataSource: WeatherTableViewDataSource?
    private var cancellables = [AnyCancellable]()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
        bindData()
    }
}

extension SearchWeatherVC: SearchWeatherViewProtocol {
    func updateUIWithData(_ data: DomainCity) {
        dataSource?.updateData(data.weathers)
    }
    
    func showErrorMessage(_ message: String) {
        showAlert(message: message)
    }
}

extension SearchWeatherVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingText = searchText
    }
}

// MARK: Private functions
extension SearchWeatherVC {
    private func setupView() {
        title = "Weather Forecast"
        dataSource = WeatherTableViewDataSource(
            tableView: tableView,
            parseWeatherCellModelBlock: { [weak self] domainWeather in
                self?.presenter?.getCellModelOf(domainWeather)
            }
        )
    }
    private func bindData() {
        $searchingText
            .removeDuplicates()
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self ] value in
                self?.presenter?.searchWithCityName(value)
            })
            .store(in: &cancellables)
    }
}
