//
//  ContentView.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var schoolsViewModel: NYCSChoolsViewModel
    @State var isShowingSATDetail = false
    @State var isAlertShown = false
    
    init(schoolsViewModel: NYCSChoolsViewModel) {
        self.schoolsViewModel = schoolsViewModel
    }
    
    var body: some View {
        
        GeometryReader { schoolGeometry in

            VStack(spacing: 0) {
                
                Text("NYC Schools")
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                
                
                List {
                    ForEach(schoolsViewModel.schoolList, id: \.self) { school in
                        HStack {
                            
                            Button {
                                //code to fetch SAT scores
                                schoolsViewModel.fetchNYCSchoolSATInfo(dbn: school.dbn)

                            } label: {

                                Text(school.schoolName)
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                            .buttonStyle(.borderless)
                            .padding(8)
                        }
                        .frame(width: schoolGeometry.size.width / 1.1)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .padding(.bottom, 16)
                    }

                }
            }
            .frame(width: schoolGeometry.size.width, height: schoolGeometry.size.height)
            .navigationDestination(isPresented: $schoolsViewModel.isShowingSATDetail) {
                SATScoresView(schoolsViewModel: schoolsViewModel)
            }
            .alert(isPresented: $schoolsViewModel.showNoInfoPrompt) {
                (Alert(title: Text("Sorry"), message: Text("This school has no current information."), dismissButton: .default(Text("OK")) {
                    
                    schoolsViewModel.showNoInfoPrompt = false
                    
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(schoolsViewModel: NYCSChoolsViewModel.mock())
    }
}
