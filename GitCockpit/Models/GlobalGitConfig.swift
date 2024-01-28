//
//  GlobalGitConfig.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 26.01.24.
//

import Foundation

// Parse the global git config file

struct GlobalGitConfig {
    private var gitConfig: GitConfig?
    

    public init() {
        let path = "\(NSHomeDirectory())/.gitconfig"
        var gitConfigt: GitConfig?
        GitConfig.parse(from: path) { result in
            switch result {
            case .success(let gitConfig):
                gitConfigt = gitConfig

            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
        self.gitConfig = gitConfigt
    }

    public func show() {
        gitConfig?.prettyPrint()
    }

    public func getContent() -> [String: [String: String]]? {
        return gitConfig?.getContent()
    }
}
