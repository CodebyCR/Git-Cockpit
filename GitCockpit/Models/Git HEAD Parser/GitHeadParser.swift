//
//  GitHeadParser.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 18.11.23.
//

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

    func getCurrentBranch() -> Result<String, GitHeadError> {
        let headPath = repoRootPath / ".git/HEAD"

        guard let headContent = readFile(atPath: headPath.path) else {
            return .failure(.fileReadError(headPath.absoluteString))
        }

        let subString = headContent
            .trimmingCharacters(in: .whitespaces)
            .split(separator: "/")
            .last

        guard let subString else {
//             print("Branch name can't be accessed.")
            return .failure(.unreadableBranchName)
        }

        return .success(String(subString))
    }

    private func readFile(atPath path: String) -> String? {
        do {
            let contents = try String(contentsOfFile: path.replacingOccurrences(of: "%20", with: " "), encoding: .utf8)
            return contents
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}
