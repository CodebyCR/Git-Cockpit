//
//  FileUtils.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 22.10.23.
//

import Foundation

struct FileUtils {
    private init() {}

    static func recursiveFileList(path: String) -> [String] {
        let fileManager = FileManager.default
        var paths: [String] = [path]

        guard let contents = try? fileManager.contentsOfDirectory(atPath: path) else {
            print("Fehler beim Lesen des Verzeichnisses: \(path)")
            return paths
        }

        for item in contents {
            let itemPath = (path as NSString).appendingPathComponent(item)
            if fileManager.isExistingDirectory(itemPath) {
                paths.append(itemPath)
                let subPaths = recursiveFileList(path: itemPath)
                paths.append(contentsOf: subPaths)
            }
        }

        return paths
    }

    static func recursiveDirectoryList(path: String) -> [String] {
        let files = FileUtils.recursiveFileList(path: path)
        return FileManager.default.filterOnFolders(from: files)
    }

    static func getLastAccessDate(forFolderPath folderPath: String) -> Date? {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: folderPath)
            if let accessDate = attributes[FileAttributeKey.modificationDate] as? Date {
                return accessDate
            }
        } catch {
            print("Fehler beim Abrufen des Zugriffsdatums: \(error)")
        }

        return nil
    }
}
