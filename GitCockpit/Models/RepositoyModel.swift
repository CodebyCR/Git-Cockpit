//
//  RepositoyModel.swift
//
//  Created by Christoph Rohde on 20.10.23.
//

import Foundation
import Logging
import System

let logger = Logger(label: "com.CodebyCR.GitCockpit") // put in env

class RepositoryModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let pathToRoot: String
    let gitConfig: GitConfig?
    var remote: String?

    var lastAccessDate: String? {
        let saferPath = pathToRoot.replacingOccurrences(of: "%20", with: " ")
        guard let accessDate = FileUtils.getLastAccessDate(forFolderPath: saferPath) else {
//            logger.info("The access Date can't be called.")
//            print("The access Date can't be called.")
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: accessDate)
    }

//    init(name: String, pathToRoot: String, remote: String?) {
//        self.id = UUID()
//        self.name = name
//        self.pathToRoot = pathToRoot.replacingOccurrences(of: "%20", with: " ")
//        let totalPath = "\(pathToRoot)\(pathToRoot.hasSuffix("/") ? ".git/config" : "/.git/config")"
//        self.gitConfig = GitConfig(atPath: totalPath)
//        self.remote = remote
//    }

    init(gitConfig: GitConfig) {
        self.id = UUID()
        self.name = gitConfig.getRepoName() ?? "Unknown"
        self.pathToRoot = gitConfig.getRepoRootPath().absoluteString.replacingOccurrences(of: "%20", with: " ")
        self.gitConfig = gitConfig
        self.remote = gitConfig.getOriginURL()?.absoluteString
    }

    static func == (lhs: RepositoryModel, rhs: RepositoryModel) -> Bool {
        return lhs.pathToRoot == rhs.pathToRoot
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(pathToRoot)
    }

    func showLocal() {
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = ["-R", pathToRoot]

        ProcessHandler
            .execute(task: task)
    }

    func showRemote() {
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = ["-a", "Safari", remote!]

        ProcessHandler
            .execute(task: task)
    }

    func getCurrentBranchName() -> String? {
        guard let rootPath = URL(string: pathToRoot) else {
            print("can't parse root path")
            return nil
        }

        let headParser = GitHeadParser(withRepositoryRoot: rootPath)
        let headParserResult = headParser.getCurrentBranch()

        switch headParserResult {
        case .success(let branchName):
//            logger.info("Current branch: \(branchName)")
            return branchName

        case .failure(let error):
            logger.error("Error: \(error.localizedDescription)")
            return nil
        }
    }

    func getName() -> String {
        let branchName = URL(fileURLWithPath: pathToRoot).lastPathComponent
        return String(branchName).replacingOccurrences(of: "%20", with: " ")
    }

    func open(editor inEditor: String) -> Process {
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = ["-R", pathToRoot]

        return task
    }
}
