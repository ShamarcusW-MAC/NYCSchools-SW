//
//  RootNavView.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import SwiftUI

struct RootNavView: View {
    
    @ObservedObject var schoolsViewModel: NYCSChoolsViewModel
    
    var body: some View {
        NavigationStack(path: $schoolsViewModel.navigationPath) {
            HomeView(schoolsViewModel: schoolsViewModel)
        }
    }
}
