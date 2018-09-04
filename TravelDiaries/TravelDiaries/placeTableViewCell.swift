//
//  placeTableViewCell.swift
//  TravelDiaries
//
//  Created by Wipro on 04/09/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Arial", size: 25)
        return lbl
    }()

    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 10
        lbl.font = UIFont(name: "Arial", size: 20)
        return lbl
    }()

    let placeImageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(placeImageView)
        addSubview(titleLabel)
        addSubview(descLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
