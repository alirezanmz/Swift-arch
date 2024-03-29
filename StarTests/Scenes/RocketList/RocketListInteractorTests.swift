//
//  RocketListInteractorTests.swift
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

class RocketListInteractorTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: RocketListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupRocketListInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupRocketListInteractor()
    {
        sut = RocketListInteractor()
    }
    
    // MARK: Test doubles
    
    class RocketListPresentationLogicSpy: RocketListPresentationLogic
    {
        var presentRocketCalled = false
        
        func presentRoketList(response: RocketList.getRocketList.Response) {
            presentRocketCalled = true
        }
    }
    
    class RocketsWorkerSpy: RocketWorker
    {
        // MARK: Method call expectations
        
        var fetchRocketCalled = false
        
        // MARK: Spied methods
        
        override func getRocketList(completionHandler: @escaping RocketListHandler, failure: @escaping ErrorHandler) {
            fetchRocketCalled = true
            let list: [Rocket] = [Seeds.Rockets.rocket1, Seeds.Rockets.rocket2]
            completionHandler(list)
        }
    }
    
    // MARK: Tests
    
    func testFetchRocketShouldAskRocketWorkerToFetchRocketsAndPresenterToFormatResult()
    {
        // Given
        let rocketListPresentationLogicSpy = RocketListPresentationLogicSpy()
        sut.presenter = rocketListPresentationLogicSpy
        let rocketsWorkerSpy = RocketsWorkerSpy()
        sut.worker = rocketsWorkerSpy
        
        // When
        let request = RocketList.getRocketList.Request()
        sut.getRockestList(request: request)
        
        // Then
        XCTAssert(rocketsWorkerSpy.fetchRocketCalled, "fetch rocket")
        XCTAssert(rocketListPresentationLogicSpy.presentRocketCalled, "rocket result")
    }
}
