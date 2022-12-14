import XCTest

@testable import P1dme

final class URLRequestTests: XCTestCase {
    func testPlatformAnalytics() {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/")!)
        request.addPlatformAnalytics()
        
        let arch = request.value(forHTTPHeaderField: "Sec-CH-UA-Arch")
        let platform = request.value(forHTTPHeaderField: "Sec-CH-UA-Platform")
        let platformVersion = request.value(forHTTPHeaderField: "Sec-CH-UA-Platform-Version")
        let model = request.value(forHTTPHeaderField: "Sec-CH-UA-Model")
        let mobile = request.value(forHTTPHeaderField: "Sec-CH-UA-Mobile")
        
        XCTAssertNotEqual(arch, "N/A")
        XCTAssertNotNil(platform)
        XCTAssertNotNil(platformVersion)
        XCTAssertNotNil(model)
        XCTAssertNotNil(mobile)
        XCTAssertTrue(mobile == "true" || mobile == "false")
        
        #if canImport(UIKit)
        XCTAssertNotEqual(platform, "N/A")
        XCTAssertNotEqual(platformVersion, "N/A")
        XCTAssertNotEqual(model, "N/A")
        #endif
        
        #if os(iOS) || os(watchOS)
            #if targetEnvironment(macCatalyst)
            XCTAssertEqual(mobile, "false")
            #else
            XCTAssertEqual(mobile, "true")
            #endif
        #else
            XCTAssertEqual(mobile, "false")
        #endif
        
        #if os(tvOS)
        XCTAssertEqual(platform, "tvOS")
        #endif
        
        #if os(watchOS)
        XCTAssertEqual(platform, "watchOS")
        #endif
        
        #if os(macOS)
        XCTAssertEqual(platform, "macOS")
        XCTAssertNotEqual(platformVersion, "N/A")
        #endif
    }
}
