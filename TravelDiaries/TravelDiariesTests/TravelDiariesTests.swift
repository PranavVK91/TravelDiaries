//
//  TravelDiariesTests.swift
//  TravelDiariesTests
//
//  Created by Wipro on 03/09/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import XCTest
@testable import TravelDiaries

class TravelDiariesTests: XCTestCase {

    var vcForTest: HomeVC!
    var testPlace: PlaceModel!
    
    override func setUp() {
        super.setUp()

        vcForTest = HomeVC()

        let dict = [ "title": "About Kerala",
                     "rows":[[
                        "title":"God’s own country",
                        "description":"Kerala tourism is a global brand and regarded as one of the destinations with highest recall.",
                        "imageHref":"https://en.wikipedia.org/wiki/Kerala#/media/File:Athirappilly_Waterfalls_1.jpg"],
                             [
                                "title":"Music",
                                "description":"The development of classical music in Kerala is attributed to the contributions it received from the traditional performance arts associated with the temple culture of Kerala.",
                                "imageHref":"https://en.wikipedia.org/wiki/Kerala#/media/File:Smitha_Rajan.JPG"],
                             [
                                "title":"Food",
                                "description":nil,
                                "imageHref":"https://en.wikipedia.org/wiki/Kerala#/media/File:Sadhya_DSW.jpg"],
                             [
                                "title":nil,
                                "description":nil,
                                "imageHref":nil]
            ]
            ] as [String : AnyObject]

        testPlace = PlaceModel(placeDetails: dict as [String : AnyObject])
        vcForTest.placeModelObj = testPlace

        self.vcForTest.loadView()
        self.vcForTest.viewDidLoad()
        self.vcForTest.viewWillAppear(true)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
         testPlace = nil
    }

    func testHasTableView()
    {
        XCTAssertNotNil(vcForTest.placeTableView)
    }

    func testVerifyTVDelegate()
    {
        XCTAssertNotNil(vcForTest.placeTableView.delegate)
        XCTAssertNotNil(vcForTest.placeTableView.dataSource)
    }

    func testAddPlaceDetails() {
       XCTAssertNotNil(vcForTest.placeModelObj)
       XCTAssertTrue(vcForTest.placeModelObj.Info.count > 0)
    }

    func testRestAPi(){
        makeWebServiceCall(urlString: travelUrl, successHandler: { (status, placeDetails) in
           XCTAssertTrue(status == "Success")
        }, failureHandler: {
            (status) in
            XCTAssertTrue(status.localizedDescription.contains("fail"))
        })
    }
}
