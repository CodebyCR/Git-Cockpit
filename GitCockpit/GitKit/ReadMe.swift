//
//  ReadMe.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 13.06.24.
//

import Foundation

struct ReadMe {
    let pathToReadMe: URL

    init?(from rootPath: String) {
        guard let readMeURL = ReadMe.findReadme(in: rootPath) else {
            print("ReadMe file can't be found.")
            return nil
        }

        self.pathToReadMe = readMeURL
    }

    /// Return the content of the ReadMe file as String.
    public func getContent() -> String? { // Maybe raw string
        guard let readMeContent = readFile(atPath: pathToReadMe.path) else {
            print("Can't decode readme file.")
            return nil
        }

        return readMeContent
    }

    private static func findReadme(in directoryPath: String) -> URL? {
        let fileManager = FileManager.default

        guard let directoryURL = URL(string: directoryPath) else {
            print("Invalid directoryPath: \(directoryPath)")
            return nil
        }

        guard fileManager.isExistingDirectory(directoryPath) else {
            print("Invalid or not existing directory: \(directoryPath)")
            return nil
        }

        let contents = try? fileManager.contentsOfDirectory(atPath: directoryPath)
        guard let fileNames = consume contents else {
            print("Directory don't conatins any file.")
            return nil
        }

        guard let readMeFileName = ReadMe.lookingForReadMeFile(in: consume fileNames) else {
            print("Directory don't conatins a ReadMe.md.")
            return nil
        }

        return directoryURL / readMeFileName
    }

    private static func lookingForReadMeFile(in fileNames: consuming [String] ) -> String? {
        for fileName in fileNames where fileName.lowercased() == "readme.md" {
            return fileName
        }

        return nil
    }


    private func readFile(atPath path: String) -> String? {
        do {
            let contents = try String(contentsOfFile: path.replacingOccurrences(of: "%20", with: " "), encoding: .utf8)
            return contents
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}
