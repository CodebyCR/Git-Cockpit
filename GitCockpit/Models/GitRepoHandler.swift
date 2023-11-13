//
//  GitRepoHandler.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 22.10.23.
//

import Foundation

struct GitRepoHandler {
    private init() {}

    static func listGitDirectories(from path: String) -> [String] {
        let directories = FileUtils.recursiveDirectoryList(path: path)
        return filterGitDirectories(fromPaths: directories)
    }

    static func createRepositoryModels(FromDirectories gitDirectories: [String]) -> [RepositoryModel] {
        var repositoryModels: [RepositoryModel] = []

        for repo in gitDirectories {
            GitConfig.parse(from: "\(repo)/.git/config") { result in
                switch result {
                case .success(let gitConfig):
//                    print("\n\(gitConfig.path)")
//                    gitConfig.prettyPrint()
                    let currentRepo = RepositoryModel(gitConfig: gitConfig)
                    repositoryModels.append(currentRepo)

                case .failure(let failure):
                    let description = GitConfig.getFailureDescription(failure)
                    print("Error: \(description)")
                }
            }
        }

        return repositoryModels
    }

    static func filterGitDirectories(fromPaths directories: [String]) -> [String] {
        var gitDirectories: [String] = []
        let fileManager = FileManager.default

        for path in directories {
            let gitPath = (path as NSString).appendingPathComponent(".git")
            if fileManager.fileExists(atPath: gitPath) {
                gitDirectories.append(path)
            }
        }

        return gitDirectories
    }
}
