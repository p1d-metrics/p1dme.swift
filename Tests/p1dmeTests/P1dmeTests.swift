import XCTest

@testable import P1dme

final class P1dmeTests: XCTestCase {
    func testPrepareCreateEventRequest() {
        try! P1dme.setup(bundle: Bundle.module, fileName: "p1dme-test")
        let request = P1dme.shared.prepareCreateEventRequest()
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "p1dme-api-key"), P1dme.shared.config.apiKey)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Referer"), P1dme.shared.referer)
    }
}
