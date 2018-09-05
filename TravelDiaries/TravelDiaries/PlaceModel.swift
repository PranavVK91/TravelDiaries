//
//  PlaceModel.swift
//  TravelDiaries
//
//  Created by Wipro on 04/09/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import Foundation

class PlaceModel: NSObject {
    var title: String = ""
    var Info = [InfoModel]()

    init(placeDetails : [String:AnyObject]) {

        title = (placeDetails["title"] as? String) ?? ""
        print("title == \(title)\n")
        let rows = placeDetails["rows"] as! [[String:AnyObject]]

        for dict in rows {

            let subTitle = (dict["title"] as? String) ?? ""
            print("subTitle == \(subTitle)")

            let description = (dict["description"] as? String) ?? ""
            print("description == \(description)")

            let imageHref = (dict["imageHref"] as? String) ?? ""
            print("imageHref == \(imageHref)")

            if subTitle != "" || description != "" || imageHref != "" {
                let infoObj = InfoModel(title: subTitle, desc: description, url: imageHref)
                Info.append(infoObj)
            }
        }
    }

    override init() { }
}

class InfoModel: NSObject {
    var title: String = ""
    var desc: String = ""
    var imageUrl: String = ""

    init(title: String, desc: String, url: String) {
        self.title = title
        self.desc = desc
        self.imageUrl = url
    }

    override init() {}
}
