//
//  NYCSchoolsViewModel.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import Foundation
import SwiftUI

class NYCSChoolsViewModel: ObservableObject {
    let app: AppController
    let manager: NetworkProtocol
        
    @Published var schoolList = [School]()
    @Published var schoolSATList = [SchoolSATInfo]()
    @Published var isShowingSATDetail = false
    @Published var showNoInfoPrompt = false
    @Published var navigationPath = NavigationPath()
    
    
    static func mock() -> NYCSChoolsViewModel{
        return AppController().nycSchoolsViewModel
    }
    
    init(app: AppController, manager: NetworkProtocol) {
        self.app = app
        self.manager = manager
        fetchNYCSchoolList()
    }
    
    func fetchNYCSchoolList() {
        Task {
            do {
                let _schools = try await manager.fetchData(endpoint: Endpoints.fetchNYCSchools(), useCache: true)
                
                await MainActor.run {
                    schoolList = _schools
                }
                
                print("Results: \(schoolList)")
            } catch let error {
                print("Error fetching school list data: \(error)")
            }
        }
    }
    
    func fetchNYCSchoolSATInfo(dbn: String) {
        
        Task {
            do {
                
                let _schoolSAT = try await manager.fetchData(endpoint: Endpoints.fetchNYCSchoolSATInfo(dbn: dbn), useCache: true)
                
                await MainActor.run {
                    schoolSATList = _schoolSAT
                    
                    //Some of the SAT information from certain schools comes back nil, so
                    //a notification prompt is shown in that said case
                    if schoolSATList.first == nil {
                        showNoInfoPrompt = true
                        isShowingSATDetail = false
                    } else {
                        showNoInfoPrompt = false
                        isShowingSATDetail = true
                    }
                }
                
            } catch let error {
                print("Error fetching school's SAT information: \(error)")
            }
        }
        
    }
}

extension NYCSChoolsViewModel {
    enum State {
        case idle
        case fetching
        case done
        case error
    }
}
