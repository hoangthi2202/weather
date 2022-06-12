//
//  WeatherCell.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWith(_ object: DomainWeather) {
        lblDate.text = "Date: \(object.date.formatString())"
        lblAverage.text = "Average Temperature: \(object.averageTemp)"
        pressure.text = "Pressure: \(object.pressure)"
        lblHumidity.text = "Humidity: \(object.humidity)"
        lblDesc.text = "Description: \(object.desc)"
    }
    
}
