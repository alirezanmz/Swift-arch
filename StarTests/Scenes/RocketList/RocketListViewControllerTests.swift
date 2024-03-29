//
//  RocketListViewControllerTests.swift
//  SpaceX
//
//  Created by Alireza Namazi on 2/6/24.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import SpaceX

import XCTest

class RocketListViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: RocketListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupRocketListViewController()
    }
    
    override func tearDown()
    {
        // window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRocketListViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "RocketListViewController") as? RocketListViewController
    }
    
    func loadView()
    {
        DispatchQueue.main.async {
            self.window.addSubview(self.sut.view)
            RunLoop.current.run(until: Date())
        }
    }
    
    // MARK: Test doubles
    
    class RocketListBusinessLogicSpy: RocketListBusinessLogic
    {
        var rockets: [Rocket]?
        var fetchRocketsCalled = false
        
        func getRockestList(request: RocketList.getRocketList.Request) {
            fetchRocketsCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testTableViewHasDataSource() {
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        sut.setUpScreen()
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        sut.setUpScreen()
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.numberOfSections(in:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
    }
    
    func testShouldFetchRocketWhenViewDidAppear()
    {
        DispatchQueue.main.async {
            // Given
            let rocketListBusinessLogicSpy = RocketListBusinessLogicSpy()
            self.sut.interactor = rocketListBusinessLogicSpy
            self.loadView()
            self.sut.viewDidAppear(true)
            XCTAssert(rocketListBusinessLogicSpy.fetchRocketsCalled, "Should fetch Rocket right after the view appears")
        }
        
    }
    
    func testEmptyList()
    {
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        let list = RocketList.getRocketList.ViewModel(displayRocketList: [])
        sut.displayRocketList(viewModel: list)
        
        XCTAssertEqual(self.sut.rocketList.count > 0 , false , "rocketList Count")
    }
    
    func testShouldDisplayGetRocket()
    {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        // When
        let displayedRocket = [RocketList.getRocketList.ViewModel.DisplayRocketList(id: "5e9d0d95eda69955f709d1eb", name: "Falcon 1", description: "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.", flickr_images: [
            "https://imgur.com/DaCfMsj.jpg",
            "https://imgur.com/azYafd8.jpg"
        ])]
        let viewModel = RocketList.getRocketList.ViewModel(displayRocketList: displayedRocket)
        sut.displayRocketList(viewModel: viewModel)
        
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched rocket should reload the table view")
    }
    
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne()
    {
        // Given
        let tableViewSpy = TableViewSpy()
        let numberOfSections = self.sut.numberOfSections(in: tableViewSpy)
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    
    func testNumberOfRowsInAnySectionShouldEqaulNumberOfOrdersToDisplay()
    {
        // Given
        let tableViewSpy = TableViewSpy()
        let testDisplayedRocket = [RocketList.getRocketList.ViewModel.DisplayRocketList(id: "5e9d0d95eda69955f709d1eb", name: "Falcon 1", description: "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.", flickr_images: [
            "https://imgur.com/DaCfMsj.jpg",
            "https://imgur.com/azYafd8.jpg"
        ])]
        sut.rocketList = testDisplayedRocket
        
        // When
        let numberOfRows = sut.tableView(tableViewSpy, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedRocket.count, "The number of table view rows should equal the number of orders to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayOrder()
    {
        // Given
        let tableViewSpy = TableViewSpy()
        let testDisplayedRocket = [RocketList.getRocketList.ViewModel.DisplayRocketList(id: "5e9d0d95eda69955f709d1eb", name: "Falcon 1", description: "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.", flickr_images: [
            "https://imgur.com/DaCfMsj.jpg",
            "https://imgur.com/azYafd8.jpg"
        ])]
        sut.rocketList = testDisplayedRocket
        
        // When
        sut.tableView = tableViewSpy
        let indexPath = IndexPath(row: 0, section: 0)
        sut.setUpScreen()
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath) as! RocketTableViewCell
        
        // Then
        XCTAssertEqual(cell.lblName.text, "Falcon 1", "A properly configured table view cell should display the rocket name")
    }
}

