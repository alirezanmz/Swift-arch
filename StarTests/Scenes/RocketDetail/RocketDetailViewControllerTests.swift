//
//  RocketDetailViewControllerTests.swift
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

class RocketDetailViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: RocketDetailViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupRocketDetailViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupRocketDetailViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "RocketDetailViewController") as! RocketDetailViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class RocketDetailBusinessLogicSpy: RocketDetailBusinessLogic
  {
    var doSomethingCalled = false
    
      func getDetail(request: RocketDetail.Roket.Request)
    {
      doSomethingCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldDoSomethingWhenViewIsLoaded()
  {
    // Given
    let spy = RocketDetailBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
  }
}
