////
////  GitConfigModelTests.swift
////  Git CockpitTests
////
////  Created by Christoph Rohde on 07.03.24.
////
//
// @testable import Git_Cockpit
// import XCTest
//
// final class GitConfigModelTests: XCTestCase {
//    // MARK: Given
//
//    private let demoGitConfigFile: String = """
//    [remote "origin"]
//        url = https://github.com/user/test-repo.git
//
//    [branch "master"]
//        merge = refs/heads/main
//        remote = origin
//    """
//
//    func testSuccessfulInit() {}
//
//    func testFailingInit() {}
//
//    func testSuccessfulInitWithFile() {}
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
// }

@testable import Git_Cockpit
import XCTest

class GitConfigTests: XCTestCase {
    var gitConfig: GitConfig!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Vorbereitung der Testdaten
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "test_gitconfig", ofType: "txt") else {
            XCTFail("Test data not found")
            return
        }
        print("Path of TestResources: \(path)")
        gitConfig = GitConfig(atPath: path)
    }

    override func tearDownWithError() throws {
        gitConfig = nil
        try super.tearDownWithError()
    }

    func testInitialization() throws {
        XCTAssertNotNil(gitConfig, "GitConfig should be initialized")
    }

    func testParsing() throws {
        XCTAssertNotNil(gitConfig.getContent(), "Content should be parsed")
        XCTAssertEqual(gitConfig.getContent().count, 2, "There should be two sections")
    }

    func testGetOriginURL() throws {
        let givenURL = gitConfig.getOriginURL()?.absoluteString
        let expectedURL = "https://github.com/example/repo.git"
        XCTAssertEqual(givenURL, expectedURL, "Incorrect origin URL")
    }

    func testGetRepoRootPath() throws {
        let givenRepoRootPath = gitConfig.getRepoRootPath().absoluteString
        let expectedRepoRootPath = "file:///path/to/repo/"
        XCTAssertEqual(givenRepoRootPath, expectedRepoRootPath, "Incorrect repo root path")
    }

    func testGetValueForKey() throws {
        let keyValue = gitConfig.getValue(forKey: "core")
        XCTAssertNotNil(keyValue, "Value for key 'core' should exist")
        XCTAssertEqual(keyValue?["repositoryformatversion"], "0", "Incorrect value for key 'repositoryformatversion'")
    }

    // Weitere Tests können hier hinzugefügt werden, je nach Bedarf
}
