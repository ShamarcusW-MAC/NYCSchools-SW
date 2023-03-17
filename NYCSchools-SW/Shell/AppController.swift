//
//  AppController.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import Foundation

class AppController {
    lazy var networkManager: NetworkManager = {
        NetworkManager()
    }()
    
    static func mock() -> AppController {
        AppController()
    }
    
    lazy var nycSchoolsViewModel: NYCSChoolsViewModel = {
        NYCSChoolsViewModel(app: self, manager: networkManager)
    }()
}
