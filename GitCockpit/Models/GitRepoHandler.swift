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

        let gitRepos = filterGitDirectories(fromPaths: directories)
//        print("-- Git Repos --\nFound repos: \(gitRepos.count)")

        for repo in gitRepos {
            let pathToRepoRoot = URL(fileURLWithPath: repo)
            // BUG: path encodig for spaces etc.
            // BUG 2: sollte auch für direkte pfade funktionieren
            let configFilePath = pathToRepoRoot.appendingPathComponent(".git/config")

//            print("Git Config: \(configFilePath)")
            let configPath = URL(fileURLWithPath: configFilePath.path())

            let gitConfig = GitConfig(atPath: configPath)
            print(gitConfig.prettyPrint())

//            if let core = gitConfig.getValue(forKey: "core") {
//                print("-- Entries --")
//                for entry in core {
//                    print(entry)
//                }
//            }
        }

        return gitRepos
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
