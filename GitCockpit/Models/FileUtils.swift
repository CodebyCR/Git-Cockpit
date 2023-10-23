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
        var paths: [String] = []

        do {
            let contents = try fileManager.contentsOfDirectory(atPath: path)
            for item in contents {
                let itemPath = (path as NSString).appendingPathComponent(item)
                var isDirectory: ObjCBool = false
                if fileManager.fileExists(atPath: itemPath, isDirectory: &isDirectory) {
                    if isDirectory.boolValue {
                        // Verzeichnispfad hinzufügen
                        paths.append(itemPath)
                        // Rekursiv Verzeichnisse durchgehen
                        let subPaths = recursiveFileList(path: itemPath)
                        paths.append(contentsOf: subPaths)
                    } else {
                        // Dateipfad hinzufügen
                        paths.append(itemPath)
                    }
                }
            }
        } catch {
            print("Fehler beim Lesen des Verzeichnisses: \(error.localizedDescription)")
        }

        return paths
    }

    static func filterFolders(fromPaths filePaths: [String]) -> [String] {
        var folderPaths: [String] = []
        filePaths.forEach { path in
            if isDirectory(path) { folderPaths.append(path) }
        }

        return folderPaths
    }

    static func recursiveDirectoryList(path: String) -> [String] {
        let files = FileUtils.recursiveFileList(path: path)
        return FileUtils.filterFolders(fromPaths: files)
    }

    static func isDirectory(_ path: String) -> Bool {
        var isDirectory: ObjCBool = false
        let fileManager = FileManager.default

        if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        }

        return false
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
