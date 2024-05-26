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

    static func getGitRepositories(from searchPaths: consuming[SearchPathModel]) -> [RepositoryModel] {
        let startTime = CFAbsoluteTimeGetCurrent()
        var uniquePaths = Set<String>()
        var repositoryModels: [RepositoryModel] = []

        for dirPath in searchPaths {
            let dirPaths = FileUtils.recursiveDirectoryList(path: dirPath.path)
            uniquePaths.formUnion(consume dirPaths)
        }

        for path in uniquePaths {
            let gitConfigPath = URL(fileURLWithPath: path).appendingPathComponent(".git/config").path
            guard FileManager.default.fileExists(atPath: consume gitConfigPath) else { continue }

            if let currentRepo = RepositoryModel(from: path) {
                repositoryModels.append(currentRepo)
            }
        }

        repositoryModels.sort { $0.getName().lowercased() < $1.getName().lowercased() }

        let endTime = CFAbsoluteTimeGetCurrent()

        let time = endTime - startTime
        print("Time needened: \(time)")

        // 0.3415480852127075
        // 0.30237090587615967
        // 0.2376459836959839
        // 0.22451496124267578

        return repositoryModels
    }

    static func getGitRepositories(for searchPaths: SearchPathModel...) -> [String] {
        let startTime = CFAbsoluteTimeGetCurrent()
        var uniquePaths = Set<String>()
        var repositoryModelsPaths: [String] = []

        for dirPath in searchPaths {
            let dirPaths = FileUtils.recursiveDirectoryList(path: dirPath.path)
            uniquePaths.formUnion(consume dirPaths)
        }

        for path in uniquePaths {
            let gitConfigPath = URL(fileURLWithPath: path).appendingPathComponent(".git/config").path
            guard FileManager.default.fileExists(atPath: consume gitConfigPath) else { continue }

            repositoryModelsPaths.append(path)
        }

        repositoryModelsPaths.sort { $0.lowercased() < $1.lowercased() }

        let endTime = CFAbsoluteTimeGetCurrent()

        let time = endTime - startTime
        print("Time needened: \(time)")

        // 0.3415480852127075
        // 0.30237090587615967
        // 0.2376459836959839
        // 0.22451496124267578

        return repositoryModelsPaths
    }
}
