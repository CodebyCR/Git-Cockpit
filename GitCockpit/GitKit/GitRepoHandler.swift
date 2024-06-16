//
//  GitRepoHandler.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 22.10.23.
//

import Foundation

struct GitRepoHandler {
    private init() {}

    static func getGitRepositories(from searchPaths: consuming[SearchPathModel]) -> [RepositoryModel] {
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

        return repositoryModels
    }

    static func getGitRepositories(for searchPaths: SearchPathModel...) -> [String] {
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

        return repositoryModelsPaths
    }
}
