//
//  ArticleListViewModelTests.swift
//  ArticleViewerTests
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import XCTest
import SwiftyJSON
@testable import CommonModule
@testable import ArticleModule
@testable import ArticleModuleService

class ArticleListViewModelTests: XCTestCase {
    var subject: ArticleListViewModel!
    var mockService: MockArticleService!
    override func setUp() {
       mockService = MockArticleService()

       subject =  ArticleListViewModel(service: mockService)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testInitialValueForViewModel() {
        XCTAssertFalse(subject.loading.value)
        XCTAssertEqual(subject.numberOfItems(), 0)
        XCTAssertNil(subject.item(for: 0))
    }

    func testViewModelForSuccessResponse() {
        let exp = expectation(description: "waiting for api call")
        subject.dataLoad {
            XCTAssertFalse(self.subject.loading.value)
            XCTAssertTrue($0)
            XCTAssertEqual(self.subject.numberOfItems(), 2)
            XCTAssertNotNil(self.subject.item(for: 0))
            exp.fulfill()
            let subSut = self.subject.item(for: 0)
            XCTAssertEqual(subSut!.title, "Barney Gumble ")
            XCTAssertEqual(subSut?.imageUrl, "https://duckduckgo.com/i/99b04638.png")
            XCTAssertEqual(subSut?.desc, "Barney Gumble - test item")


        }
        wait(for: [exp], timeout: 6)
    }

    func testViewModelForFailResponse() {
      mockService = MockArticleService()
       mockService.mockType = .fail

        subject =  ArticleListViewModel(service: mockService)

        subject.errorHandler = { (title, message) in
            XCTAssertNil(title)
            XCTAssertEqual(message, "The operation couldn’t be completed. (customError error 200.)")
        }

        let exp = expectation(description: "waiting for api call")
        subject.dataLoad {
            XCTAssertFalse(self.subject.loading.value)
            XCTAssertFalse($0)
            XCTAssertEqual(self.subject.numberOfItems(), 0)
            XCTAssertNil(self.subject.item(for: 0))
            exp.fulfill()
        }
        wait(for: [exp], timeout: 6)


    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
