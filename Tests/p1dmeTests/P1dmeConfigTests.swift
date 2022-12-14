import XCTest

@testable import P1dme

final class P1dmeConfigTests: XCTestCase {
    
    func testLoadConfig() {
        guard let config = try? Config.parse(bundle: Bundle.module, fileName: "p1dme-test") else {
            XCTFail("Fail to load config file")
            return
        }
        XCTAssertEqual(config.applicationId, "com.p1dme.tests.ios")
        XCTAssertEqual(config.serviceURL.absoluteString, "http://127.0.0.1:8080/")
        XCTAssertEqual(config.apiKey, "test-key")
    }
    
    func testInitWithValues() {
        try! P1dme.setup(serviceURL: URL(string: "http://127.0.0.1:8080/")!, apiKey: "test-key")
    }
    
    
    #if CA_TEST_HTTP_REQUEST
    func testPostEvent() {
        try! P1dme.setup(bundle: Bundle.module, fileName: "p1dme-test")
        let expectation = XCTestExpectation(description: "Expect HTTP response")
        
        P1dme.shared.logEvent(name: "test-event") { event, error in
            XCTAssertNotNil(event)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 120.0)
    }
    
    func testPostEventWithCategory() {
        try! P1dme.setup(bundle: Bundle.module, fileName: "p1dme-test")
        let expectation = XCTestExpectation(description: "Expect HTTP response")
        
        P1dme.shared.logEvent(name: "test-event", category: "test") { event, error in
            XCTAssertNotNil(event)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 120.0)
    }

    func testPostEventWithCategoryAndParams() {
        try! P1dme.setup(bundle: Bundle.module, fileName: "p1dme-test")
        let expectation = XCTestExpectation(description: "Expect HTTP response")
        
        P1dme.shared.logEvent(name: "test-event",
                              category: "test",
                              parameters: [
                                "key1": "value1",
                                "key2": "value2",
                              ]) { event, error in
            XCTAssertNotNil(event)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 120.0)
    }
    #endif
}
