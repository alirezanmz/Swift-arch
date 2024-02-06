//
//  RocketDetailInteractorTests.swift
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

class RocketDetailInteractorTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: RocketDetailInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupRocketDetailInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRocketDetailInteractor()
    {
        sut = RocketDetailInteractor()
    }
    
    // MARK: Test doubles
    
    class RocketDetailPresentationLogicSpy: RocketDetailPresentationLogic
    {
        var presentDetailCalled = false
        
        func presentDetail(response: RocketDetail.Roket.Response)
        {
            presentDetailCalled = true
        }
    }
    
    class RocketsWorkerSpy: RocketWorker
    {
        // MARK: Method call expectations
        
        var fetchRocketCalled = false
        
        // MARK: Spied methods
        override func getRocketDetail(id: String, completionHandler: @escaping RocketDetailHandler, failure: @escaping ErrorHandler) {
            fetchRocketCalled = true
            let detail: Rocket = Seeds.Rockets.rocket1
            completionHandler(detail)
        }
    }
    
    // MARK: Tests
    
    func testFetchRocketShouldAskRocketWorkerToFetchRocketsAndPresenterToFormatResult()
    {
        // Given
        let spy = RocketDetailPresentationLogicSpy()
        sut.presenter = spy
        let rocketsWorkerSpy = RocketsWorkerSpy()
        sut.worker = rocketsWorkerSpy
        
        // When
        let request = RocketDetail.Roket.Request(id: "5e9d0d95eda69955f709d1eb")
        sut.getDetail(request: request)
        
        // Then
        XCTAssert(rocketsWorkerSpy.fetchRocketCalled, "fetch rocket")
        XCTAssert(spy.presentDetailCalled, "favorite result")
        
    }
}
