//////
//////  GitHeadParser.swift
//////  Git Cockpit
//////
//////  Created by Christoph Rohde on 18.11.23.
//////
////
//// import Foundation
////
//// struct GitHeadParser {
////    let repoRootPath: URL
////    let headPath: URL?
////
////    init(withReposetoryRoot path: URL) {
////        self.repoRootPath = path
////        self.headPath = URL(string: "\(repoRootPath)/.git/HEAD")
////    }
////
////    func getCurrentBranch() -> String? {
////        guard let headPath else {
////            print("Undefined HEAD file for git repo at: \(repoRootPath)") // later as error
////            return nil
////        }
////
////        if let headContent = readFile(atPath: headPath.path) {
////            let subString = headContent
////                .trimmingCharacters(in: .whitespaces)
////                .split(separator: "/")
////                .last
////
////            guard let subString else {
////                print("Branch name can't be accessed.")
////                return nil
////            }
////            return String(subString)
////        }
////
////        print("HEAD file can't be parsed")
////        return nil
////    }
////
////    private func readFile(atPath path: String) -> String? {
////        do {
////            let contents = try String(contentsOfFile: path, encoding: .utf8)
////            return contents
////        } catch {
////            print("Error reading file: \(error)")
////            return nil
////        }
////    }
//// }
//
// import Foundation
//
// struct GitHeadParser {
//    let repoRootPath: URL
//    let headPath: URL?
//
//    init(withRepositoryRoot path: URL) {
//        self.repoRootPath = path
//        self.headPath = URL(string: "\(repoRootPath)/.git/HEAD")
//    }
//
////    func getCurrentBranch() -> String? {
////        guard let headPath = headPath else {
////            print("Undefined HEAD file for git repo at: \(repoRootPath)")
////            return nil
////        }
////
////        do {
////            let headContent = try readFile(atPath: headPath.path)
////
////            let subString = headContent
////                .trimmingCharacters(in: .whitespacesAndNewlines)
////                .split(separator: "/")
////                .last
////
////            guard let subString = subString else {
////                print("Branch name can't be accessed.")
////                return nil
////            }
////
////            return String(subString)
////        } catch {
////            print("Error reading or parsing HEAD file: \(error)")
////            return nil
////        }
////    }
//
//    func getCurrentBranch() -> String? {
//        let task = Process()
//        task.launchPath = "/usr/bin/env"
//        task.arguments = ["git", "-C", repoRootPath.path, "rev-parse", "--abbrev-ref", "HEAD"]
//
//        let pipe = Pipe()
//        task.standardOutput = pipe
//        task.launch()
//
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        task.waitUntilExit()
//
//        if task.terminationStatus == 0 {
//            if let branchName = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
//                return branchName
//            }
//        }
//
//        return nil
//    }
//
//    private func readFile(atPath path: String) throws -> String {
//        let contents = try String(contentsOfFile: path, encoding: .utf8)
//        return contents
//    }
// }
//
////// Beispiel-Nutzung:
//// let parser = GitHeadParser(withRepositoryRoot: URL(fileURLWithPath: "/path/to/your/repo"))
//// if let branch = parser.getCurrentBranch() {
////    print("Current branch: \(branch)")
//// } else {
////    print("Failed to retrieve current branch.")
//// }

import Foundation

enum GitHeadError: Error {
    case undefinedRepoPath
    case fileReadError(String)
    case unreadableBranchName
    case unparsable

    var localizedDescription: String {
        switch self {
        case .undefinedRepoPath:
            return "Undefined repository path."
        case .fileReadError(let details):
            return "Error reading file at: \(details)"
        case .unreadableBranchName:
            return "Error unreadable branch name."
        case .unparsable:
            return "HEAD file can't be parsed"
        }
    }
}

struct GitHeadParser {
    let repoRootPath: URL

    init(withRepositoryRoot path: URL) {
        self.repoRootPath = path
    }

//    func getCurrentBranch() -> Result<String, GitHeadError> {
//        guard FileManager.default.fileExists(atPath: repoRootPath.path) else {
//            return .failure(.undefinedRepoPath)
//        }
//
//        let task = Process()
//        task.launchPath = "/usr/bin/env"
//        task.arguments = ["git", "-C", repoRootPath.path, "rev-parse", "--abbrev-ref", "HEAD"]
//
//        let pipe = Pipe()
//        task.standardOutput = pipe
//        task.launch()
//
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        task.waitUntilExit()
//
//        if task.terminationStatus == 0 {
//            if let branchName = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
//                return .success(branchName)
//            }
//        }
//
//        return .failure(.branchAccessError)
//    }

    func getCurrentBranch() -> Result<String, GitHeadError> {
        let headPath = URL(fileURLWithPath: "\(repoRootPath)/.git/HEAD")

//        guard let headPath else {
//            // print("Undefined HEAD file for git repo at: \(repoRootPath)") // later as error
//            return .failure(.undefinedRepoPath)
//        }

        guard let headContent = readFile(atPath: headPath.path) else {
            return .failure(.fileReadError(headPath.absoluteString))
        }

        let subString = headContent
            .trimmingCharacters(in: .whitespaces)
            .split(separator: "/")
            .last

        guard let subString else {
//                    print("Branch name can't be accessed.")

            return .failure(.unreadableBranchName)
        }
        return .success(String(subString))
    }

    private func readFile(atPath path: String) -> String? {
        do {
            let contents = try String(contentsOfFile: path, encoding: .utf8)
            return contents
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}
