//
//  ViewController.swift
//  TravelDiaries
//
//  Created by Wipro on 03/09/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import SDWebImage
import PureLayout

class HomeVC: UIViewController {

    let tableView: UITableView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let loader = UIActivityIndicatorView(forAutoLayout: ())
        loader.color = .black
        loader.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        self.view.addSubview(loader)
        loader.startAnimating()
        loader.autoCenterInSuperview()

        invokeWebServiceAPI()
    }

    func setupHomePage(placeDetails : [String:AnyObject])
    {
        let title = placeDetails["title"] as! String
        print("title == \(title)\n")
        let rows = placeDetails["rows"] as! [[String:AnyObject]]

        DispatchQueue.main.async {
            self.tabBarItem.title = title
        }

        for dict in rows {

            let title1 = (dict["title"] as? String) ?? ""
            print("title == \(title1)")

            let description = (dict["description"] as? String) ?? ""
            print("description == \(description)")

            let imageHref = (dict["imageHref"] as? String) ?? ""
            print("imageHref == \(imageHref)")
        }
    }

    func invokeWebServiceAPI()
    {
       makeWebServiceCall(urlString: travelUrl, successHandler: { (status, placeDetails) in
        self.setupHomePage(placeDetails: placeDetails)
        }, failureHandler: {
            (status) in
            print("failed")
        })
    }
}

