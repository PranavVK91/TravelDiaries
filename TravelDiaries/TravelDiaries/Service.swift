//
//  Service.swift
//  TravelDiaries
//
//  Created by Wipro on 03/09/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func makeWebServiceCall(urlString : String ,successHandler : @escaping(String,[String: AnyObject])->Void, failureHandler: @escaping(Error)->Void) {
    let header: [String:String] = ["Content-Type" : "application/json"]
    var json = [String:AnyObject]()
    Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseString{ (response) in

        guard response.error == nil else {
            print("Webservice call failed")
            failureHandler(response.error!)
            return
        }

        guard response.result.value != nil else {
            print("Invalid Json")
            failureHandler("failure" as! Error)
            return
        }

        let jsonText = response.result.value

        if let data = jsonText?.data(using: String.Encoding.utf8) {

            do {
                json = (try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject])!
                successHandler("Success",json)
            }
            catch let error as NSError {
                print(error)
                failureHandler("failure" as! Error)
            }
        }
    }
}
