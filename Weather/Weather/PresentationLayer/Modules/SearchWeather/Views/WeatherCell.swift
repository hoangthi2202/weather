//
//  WeatherCell.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import UIKit
import SDWebImage

struct WeatherCellModel {
    let dateStr: String
    let averageTempStr: String
    let pressureStr: String
    let humidityStr: String
    let desc: String
    let iconURL: URL?
}

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
    
    func setupWithModel(_ model: WeatherCellModel) {
        lblDate.text = model.dateStr
        lblAverage.text = model.averageTempStr
        pressure.text = model.pressureStr
        lblHumidity.text = model.humidityStr
        lblDesc.text = model.desc
        imgIcon.sd_setImage(
            with: model.iconURL,
            placeholderImage: nil,
            options: .retryFailed,
            completed: { _, error, _, _ in
                if let error = error {
                    WLog.debug(error)
                }
            }
        )
    }
    
}
