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

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK :- Variable and constants

    var placeTableView: UITableView!
    var placeModelObj = PlaceModel()

    //MARK :- Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let loader = UIActivityIndicatorView(forAutoLayout: ())
        loader.color = .black
        loader.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        self.view.addSubview(loader)
        loader.startAnimating()
        loader.autoCenterInSuperview()
        setupTableView()
        invokeWebServiceAPI()
    }

    //MARK :- Setup Initial Views

    func setupHomePage(placeDetails: [String:AnyObject])
    {
        placeModelObj = PlaceModel(placeDetails: placeDetails)
        DispatchQueue.main.async {
            self.setNavBarToTheView(title: self.placeModelObj.title)
            self.placeTableView.isHidden = false
            self.placeTableView.reloadData()
        }
    }

    func setupTableView()
    {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        placeTableView = UITableView(frame: CGRect(x: 0, y: 40, width: displayWidth, height: displayHeight - barHeight))
        placeTableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        placeTableView.dataSource = self
        placeTableView.delegate = self
        self.view.addSubview(placeTableView)
        placeTableView.isHidden = true
    }

    //MARK :- TableView DataSource Methods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeModelObj.Info.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell

        cell.titleLabel.frame = CGRect(x: 0.0, y: 0.0, width: cell.frame.width, height: 50)
        cell.descLabel.frame = CGRect(x: 0.0, y:  (cell.titleLabel.frame.height), width: cell.frame.width, height: 100)
        cell.placeImageView.frame = CGRect(x: 0.0, y: 0.0, width: cell.frame.width, height: cell.frame.height)

        let placeDetails = placeModelObj.Info[indexPath.row]
        cell.titleLabel.text = placeDetails.title
        cell.descLabel.text = placeDetails.desc

        cell.placeImageView.sd_setImage(with: URL(string: placeDetails.imageUrl), placeholderImage: UIImage(named: "placeHolder") , options: [], completed: { (image, error, cachetype, url) in
            if image != nil {
                DispatchQueue.main.async {
                    cell.placeImageView.image = image
                }
            }
            else {
                DispatchQueue.main.async {
                    cell.placeImageView.image = UIImage(named: "placeHolder")
                }
            }
        })

        cell.titleLabel.bringSubview(toFront: cell.placeImageView)
        cell.descLabel.bringSubview(toFront: cell.placeImageView)
        cell.titleLabel.layer.zPosition = 1
        cell.titleLabel.layer.zPosition = 1
        return cell
    }

    //MARK :- Custom Methods

    func invokeWebServiceAPI()
    {
       makeWebServiceCall(urlString: travelUrl, successHandler: { (status, placeDetails) in
        self.setupHomePage(placeDetails: placeDetails)
        }, failureHandler: {
            (status) in
            print("failed")
            DispatchQueue.main.async {
                self.showAlert(title: "Alert", Message: "Connectivity issue")
            }
        })
    }

    func setNavBarToTheView(title: String) {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80.0))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: title)
        navBar.setItems([navItem], animated: true)
    }

    func showAlert(title : String , Message : String)
    {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

