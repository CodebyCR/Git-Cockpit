//
//  FileManagerExtension.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 04.04.24.
//

import Foundation

extension FileManager {
    func isExistingDirectory(_ path: consuming String) -> Bool {
        var isDirectory: ObjCBool = false
        let saferPath = path.replacingOccurrences(of: "%20", with: " ")

        if fileExists(atPath: consume saferPath, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        }

        return false
    }

    func filterOnFolders(from filePaths: consuming [String]) -> [String] {
        var folderPaths: [String] = []
        for path in filePaths where isExistingDirectory(path) {
            folderPaths.append( consume path)
        }

        return folderPaths
    }
}
