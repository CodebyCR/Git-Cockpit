//
//  GitRepoHandler.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 22.10.23.
//

import Foundation

struct GitRepoHandler {
    private init() {}



//    static func getGitRepositories(forSearchPaths searchPaths: [SearchPathModel]) -> [RepositoryModel] {
//        return searchPaths.flatMap { searchPath -> [RepositoryModel] in
//            let gitDirectories = FileUtils.recursiveDirectoryList(path: searchPath.path).filter { path in
//                // Use Path instead of NSString for better type safety
//                FileManager.default.fileExists(atPath: path.appending(".git"))
//            }
//
//            return gitDirectories.compactMap { gitDirectory -> RepositoryModel? in
//                let configPath = gitDirectory.appending(".git/config")
//                guard let gitConfig = GitConfig(atPath: configPath) else {
//                    print("Not found at: \(configPath)")
//                    return nil
//                }
//                let repositoryModel = RepositoryModel(gitConfig: gitConfig)
//                return repositoryModel
//            }
//        }.sorted(by: { $0.name.lowercased() < $1.name.lowercased() }) // Assuming `name` is the property
//    }

    private static func listGitDirectories(from path: consuming String) -> [String] {
        let directories = FileUtils.recursiveDirectoryList(path: path)
        return filterGitDirectories(fromPaths: directories)
    }

    private static func createRepositoryModels(from gitDirectories: consuming[String]) -> [RepositoryModel] {
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

       private  static func filterGitDirectories(fromPaths directories: consuming[String]) -> [String] {
        var gitDirectories: [String] = []
        let fileManager = FileManager.default
        let uniqueDirectories = Set(directories)

        for path in uniqueDirectories {
            let gitPath = (path as NSString).appendingPathComponent(".git/config")
            if fileManager.fileExists(atPath: consume gitPath) {
                gitDirectories.append(path)
            }
        }

        return gitDirectories
    }

    static func getGitRepositories(from seachPaths: consuming[SearchPathModel]) -> [RepositoryModel] {
        var repoModels: [RepositoryModel] = []

        for dirPath in seachPaths {
            let gitDirectories = GitRepoHandler.listGitDirectories(from: dirPath.path)
            let gitRepos = GitRepoHandler.createRepositoryModels(from: consume gitDirectories)
            repoModels.append(contentsOf: consume gitRepos)
        }

        repoModels.sort(by: { $0.getName().lowercased() < $1.getName().lowercased() })
        return repoModels
    }
}
