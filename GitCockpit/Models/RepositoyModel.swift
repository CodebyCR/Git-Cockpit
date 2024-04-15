//
//  RepositoyModel.swift
//
//  Created by Christoph Rohde on 20.10.23.
//

import Foundation
import Logging
import System

let logger = Logger(label: "com.CodebyCR.GitCockpit") // put in env

class RepositoryModel: Identifiable, Hashable, ObservableObject {
    let id: UUID
    let name: String
    let pathToRoot: String
    let gitConfig: GitConfig?
    var remote: String?

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

    func open(editor inEditor: String) -> Process {
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = ["-R", pathToRoot]

        return task
    }

    /// Return the Repository name
    func getName() -> String {
        let branchName = URL(fileURLWithPath: pathToRoot).lastPathComponent
        return String(branchName).replacingOccurrences(of: "%20", with: " ")
    }

    /// Return the currently selected branch name
    /// or nil if the git HEAD file can't be read
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

    /// Return the last date where the finder tracked an access on Folder path
    var lastAccessDate: String? {
        let saferPath = pathToRoot.replacingOccurrences(of: "%20", with: " ")
        guard let accessDate = FileUtils.getLastAccessDate(forFolderPath: saferPath) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: accessDate)
    }
}
