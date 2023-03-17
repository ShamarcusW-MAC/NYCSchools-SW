//
//  SATScoresView.swift
//  NYCSchools-SW
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import SwiftUI

struct SATScoresView: View {
    @ObservedObject var schoolsViewModel: NYCSChoolsViewModel
    var body: some View {
        
        GeometryReader { schoolGeometry in
            
            //This code is a bit repetetive, so to improve it, I would likely
            //set each HStack listed here built in a separate function to clean
            //up the code.
            
            VStack(spacing: 16) {
                
                Text(schoolsViewModel.schoolSATList.first?.schoolName ?? "")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                                
                VStack (spacing: 32){
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Number of Test Takers")
                            .padding(.leading, 32)
                        
                        Spacer()
                        
                        Text(schoolsViewModel.schoolSATList.first?.numTestTakers ?? "0" )
                            .padding(.trailing, 32)

                        
                    }
                    .frame(width: schoolGeometry.size.width)
                    
                    Divider()
                    
                    HStack {
                        
                        Text("SAT Critical Reading Average Score")
                            .padding(.leading, 32)
                        
                        Spacer()
                        
                        Text(schoolsViewModel.schoolSATList.first?.satReadingAvgScore ?? "0" )
                            .padding(.trailing, 32)
                        
                    }
                    .frame(width: schoolGeometry.size.width)
                    
                    Divider()
                    
                    HStack {
                        
                        Text("SAT Math Average Score")
                            .padding(.leading, 32)
                        
                        Spacer()
                        
                        Text(schoolsViewModel.schoolSATList.first?.satMathAvgScore ?? "0" )
                            .padding(.trailing, 32)
                        
                    }
                    .frame(width: schoolGeometry.size.width)
                    
                    
                    Divider()
                    
                    HStack {
                        
                        Text("SAT Writing Average Score")
                            .padding(.leading, 32)
                        
                        Spacer()
                        
                        Text(schoolsViewModel.schoolSATList.first?.satWritingAvgScore ?? "0" )
                            .padding(.trailing, 32)
                        
                    }
                    .frame(width: schoolGeometry.size.width)
                    
                }
                Divider()
                
                Spacer()

                
                
            }
            .frame(width: schoolGeometry.size.width, height: schoolGeometry.size.height)
            
        }
        
    }
}

struct SATScoresView_Previews: PreviewProvider {
    static var previews: some View {
        SATScoresView(schoolsViewModel: NYCSChoolsViewModel.mock())
    }
}
