//
//  WeatherTableViewDataSource.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import UIKit

class WeatherTableViewDataSource: NSObject {
    typealias ParseWeatherCellModelBlock = (DomainWeather) -> WeatherCellModel?
    private weak var tableView: UITableView?
    private var data = [DomainWeather]()
    private var parseWeatherCellModelBlock: ParseWeatherCellModelBlock
    init(tableView: UITableView, parseWeatherCellModelBlock: @escaping ParseWeatherCellModelBlock) {
        self.tableView = tableView
        self.parseWeatherCellModelBlock = parseWeatherCellModelBlock
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil),
                           forCellReuseIdentifier: "WeatherCell")
    }
    
    func updateData(_ data: [DomainWeather]?) {
        if let data = data {
            self.data = data.sorted(by: { item1, item2 in
                item1.date.timeIntervalSince1970 < item2.date.timeIntervalSince1970
            })
        } else {
            self.data.removeAll()
        }
        
        tableView?.reloadData()
    }
}

extension WeatherTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as? WeatherCell
        else {
            return UITableViewCell()
        }
        
        if let model = parseWeatherCellModelBlock(data[indexPath.row]) {
            cell.setupWithModel(model)
        }
        return cell
    }
}

extension WeatherTableViewDataSource: UITableViewDelegate {
    
}
