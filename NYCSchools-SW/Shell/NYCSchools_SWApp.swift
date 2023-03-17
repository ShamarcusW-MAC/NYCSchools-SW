//
//  NYCSchools_SWApp.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import SwiftUI

@main
struct NYCSchools_SWApp: App {
    let app = AppController()
    var body: some Scene {
        WindowGroup {
            RootNavView(schoolsViewModel: app.nycSchoolsViewModel)
        }
    }
}
