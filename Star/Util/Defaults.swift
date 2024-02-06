//
//  Defaults.swift
//  Star
//
//  Created by Alireza Namazi on 2/06/24.
//

import Foundation

struct Defaults {
    
    private let rocketsKey = "rockets"
    private let userDefault = UserDefaults.standard
    static let shared = Defaults()
    
    func save(_ rocketId: String){
        var allRocket = getRockets()
        allRocket.append(rocketId)
        userDefault.set(allRocket,
                        forKey: rocketsKey)
    }
    
    func getRockets() -> [String] {
        return ((userDefault.value(forKey: rocketsKey) as? [String]) ?? [])
    }
    
    func removeRocket(_ rocketId: String) {
        var allRocket = getRockets()
        let rocketIndex = allRocket.firstIndex(where: {$0 == rocketId})!
        allRocket.remove(at: rocketIndex)
        userDefault.set(allRocket,
                        forKey: rocketsKey)
    }
    
    func isRocketExist(_ rocketId: String) -> Bool {
        let allRocket = getRockets()
        return (allRocket.firstIndex(where: {$0 == rocketId}) != nil)
    }

    private func clearUserData(){
        userDefault.removeObject(forKey: rocketsKey)
    }
}
