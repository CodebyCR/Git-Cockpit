//
//  RepositoyModel.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 20.10.23.
//

import Foundation

class RepositoryModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let pathToRoot: String
    let gitConfig: GitConfig?
    var remote: String?

    var lastAccessDate: String? {
        guard let accessDate = FileUtils.getLastAccessDate(forFolderPath: pathToRoot) else {
            print("The access Date can't be called.")
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: accessDate)
    }

    init(name: String, pathToRoot: String, remote: String?) {
        self.id = UUID()
        self.name = name
        self.pathToRoot = pathToRoot
        self.gitConfig = GitConfig(atPath: "\(pathToRoot)/.git/config")
        self.remote = remote
    }

    init(gitConfig: GitConfig) {
        self.id = UUID()
        self.name = gitConfig.getRepoName() ?? "Unknown"
        self.pathToRoot = gitConfig.getRepoRootPath().absoluteString
        self.gitConfig = gitConfig
        self.remote = gitConfig.getOriginURL()?.absoluteString
    }

    static func getDemoRepos() -> [RepositoryModel] {
        let demo = RepositoryModel(name: "Git-Cockpit",
                                   pathToRoot: "/Users/christoph_rohde/Documents/New/GitCockpit",
                                   remote: nil)

        let timedAction = RepositoryModel(name: "Timed-Action",
                                          pathToRoot: "/Users/christoph_rohde/CLionProjects/TimedAction",
                                          remote: "https://github.com/CodebyCR/TimedAction")

        let qrala = RepositoryModel(name: "Qrala",
                                    pathToRoot: "/Users/christoph_rohde/PycharmProjects/Qrala",
                                    remote: "https://github.com/CodebyCR/Qrala")

        return [demo, timedAction, qrala]
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

    // TODO:
//    - Add branch name,
//    - open in (editor)
}
