//
//  NYCSChoolsViewModelTest.swift
//  NYCSchools-SWTests
//
//  Created by Sha'Marcus Walker on 3/16/23.
//

import XCTest
@testable import NYCSchools_SW

final class NYCSChoolsViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testfetchNYCSchoolList_When_Everything_isCorrect() {
        let fakeController =  AppController()
        let schoolsViewModel = NYCSChoolsViewModel(app: fakeController, manager: FakeNetworkManager())

        XCTAssertNotNil(schoolsViewModel)
        
        let expectation = XCTestExpectation(description: "Fetching Schools list")
         schoolsViewModel.fetchNYCSchoolList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            XCTAssertEqual(schoolsViewModel.schoolList.count,2)
            let school = schoolsViewModel.schoolList.first
            XCTAssertEqual("Clinton School Writers & Artists, M.S. 260",school?.schoolName)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        
    }

    
    func testfetchNYCSchoolSATInfo_When_Everything_isCorrect() {
        let fakeController =  AppController()
        let schoolsViewModel = NYCSChoolsViewModel(app: fakeController, manager: FakeSATNetworkManager())

        XCTAssertNotNil(schoolsViewModel)
        
        let expectation = XCTestExpectation(description: "Fetching School's SAT data")
        schoolsViewModel.fetchNYCSchoolSATInfo(dbn: "08X282")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            let schoolSATInfo = schoolsViewModel.schoolSATList.first
            XCTAssertEqual("WOMEN'S ACADEMY OF EXCELLENCE",schoolSATInfo?.schoolName)
            XCTAssertEqual("44",schoolSATInfo?.numTestTakers)
            XCTAssertEqual("407",schoolSATInfo?.satReadingAvgScore)
            XCTAssertEqual("386",schoolSATInfo?.satMathAvgScore)
            XCTAssertEqual("378",schoolSATInfo?.satWritingAvgScore)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
