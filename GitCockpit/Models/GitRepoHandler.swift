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
            let repoPath = repo.hasSuffix("/") ? "\(repo).git/config" : "\(repo)/.git/config"

            GitConfig.parse(from: repoPath) { result in
                switch result {
                case .success(let gitConfig):
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
        let uniqueDirectories = Set(directories)

        for path in uniqueDirectories {
            let gitPath = (path as NSString).appendingPathComponent(".git/config")
            if fileManager.fileExists(atPath: gitPath) {
                gitDirectories.append(path)
            }
        }

        return gitDirectories
    }

    static func getGitRepositories(ForSeachPaths seachPaths: [SearchPathModel]) -> [RepositoryModel] {
        var repoModels: [RepositoryModel] = []

        for dirPath in seachPaths {
            let gitDirectories = GitRepoHandler.listGitDirectories(from: dirPath.path)
            let gitRepos = GitRepoHandler.createRepositoryModels(FromDirectories: gitDirectories)
            repoModels.append(contentsOf: gitRepos)
        }

        repoModels.sort(by: { $0.getName().lowercased() < $1.getName().lowercased() })
        return repoModels
    }
}
