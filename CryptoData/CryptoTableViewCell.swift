//
//  CryptoTableViewCell.swift
//  CryptoData
//
//  Created by Мария Изюменко on 31.01.2022.
//

import UIKit

struct CryptoTableViewCellViewModel {
    let name: String
    let symbol: String
    let price: String
}

class CryptoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "CryptoTableViewCell"
    
    func configure (with viewModels: CryptoTableViewCellViewModel) {
        symbolLabel.text = viewModels.symbol
        nameLabel.text = viewModels.name
        priceLabel.text = viewModels.price
    }
    
}
