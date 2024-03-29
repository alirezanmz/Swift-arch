//
//  RocketListPresenter.swift
//  Star
//
//  Created by Alireza Namazi on 2/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RocketListPresentationLogic
{
    func presentRoketList(response: RocketList.getRocketList.Response)
}

class RocketListPresenter: RocketListPresentationLogic
{
  weak var viewController: RocketListDisplayLogic?
  
  // MARK: Do something
  
  func presentRoketList(response: RocketList.getRocketList.Response)
  {
      var list: [RocketList.getRocketList.ViewModel.DisplayRocketList] = []
      for rocket in response.rocketList {
          let model = RocketList.getRocketList.ViewModel.DisplayRocketList(id: rocket.id ?? "", name: rocket.name ?? "", description: rocket.description ?? "", flickr_images: rocket.flickrImages ?? [])
          list.append(model)
      }
      let viewModel = RocketList.getRocketList.ViewModel(displayRocketList: list)
      viewController?.displayRocketList(viewModel: viewModel)
  }
}
