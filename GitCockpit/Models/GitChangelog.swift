//
//  GitChangelog.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 15.02.24.
//

import Foundation

enum FileReadError: Error {
    case unableToReadData
    case unableToDecodeString
    case taskExecutionFailed(Int32)
}

struct GitChangelog {
    /// Liest Daten aus einem FileHandle und gibt sie als String zurück.
    func readDataFromFileHandle(_ fileHandle: FileHandle) -> Result<String, FileReadError> {
        guard let data = try? fileHandle.readToEnd() else {
            return .failure(.unableToReadData)
        }
        let output = String(decoding: data, as: UTF8.self)

        return .success(output)
    }

    /// Ruft die Branches eines Git-Repos ab.
    ///
    /// - Parameter url: Die URL des Git-Repos.
    /// - Returns: Ein Array mit den Branch-Namen oder nil im Fehlerfall.
    func getBranches(fromURL url: URL) -> [String]? {
        // Task zum Ausführen des `git branch`-Befehls
        let task = Process()
        task.launchPath = "/usr/bin/git"
        task.arguments = ["branch", "-r"]
        task.currentDirectoryURL = url

        // Pipe zum Abfangen der Ausgabe des Befehls
        let pipe = Pipe()
        task.standardOutput = pipe

        // Starten des Tasks
        do {
           try task.run()
        } catch {
           print("Task run failed.")
           return []
        }

        let rawBranches = readLinesFromPipe(pipe)

        // Parsen der Ausgabe und Extrahieren der Branch-Namen
        let branches = rawBranches?.filter { !$0.isEmpty }

        // Rückgabe der Branch-Namen
        return branches
    }

    /// Ruft die Tags eines Git-Branches ab.
    ///
    /// - Parameters:
    ///   - branch: Der Name des Branches.
    ///   - url: Die URL des Git-Repos.
    /// - Returns: Ein Array mit den Tag-Namen oder nil im Fehlerfall.
    func getTags(forBranch branch: String, fromURL url: URL) -> [String]? {
        // Task zum Ausführen des `git tag`-Befehls
        let task = Process()
        task.launchPath = "/usr/bin/git"
        task.arguments = ["tag", "-l", branch]
        task.currentDirectoryURL = url

        // Pipe zum Abfangen der Ausgabe des Befehls
        let pipe = Pipe()
        task.standardOutput = pipe

        // Starten des Tasks
        do {
            try task.run()
        } catch {
            print("Task run failed.")
            return []
        }

        let rawTags = readLinesFromPipe(pipe)

        // Parsen der Ausgabe und Extrahieren der Tag-Namen
        let tags = rawTags?.filter { !$0.isEmpty }

        // Rückgabe der Tag-Namen
        return tags
    }

    /// Ruft die Beschreibung eines Tags ab.
    ///
    /// - Parameters:
    ///   - tag: Der Name des Tags.
    ///   - url: Die URL des Git-Repos.
    ///   - completion: Ein Handler, der mit der Beschreibung des Tags aufgerufen wird.
    func getTagDescription(forTag tag: String, fromURL url: URL, completion: @escaping (String?) -> Void) {
        // Task zum Ausführen des `git show`-Befehls
        let task = Process()
        task.launchPath = "/usr/bin/git"
        task.arguments = ["show", tag]
        task.currentDirectoryURL = url

        // Pipe zum Abfangen der Ausgabe des Befehls
        let pipe = Pipe()
        task.standardOutput = pipe

        // Starten des Tasks
        guard let _ = try? task.run() else {
            print("Task run failed.")
            return
        }

        // Array zum Speichern der Beschreibungen
        var descriptions: [String] = []

        // Handler zum Lesen der Ausgabe des Befehls
        pipe.fileHandleForReading.readabilityHandler = { fileHandle in
            // Lesen der Ausgabe des Befehls
            let data = fileHandle.availableData

            let output = String(decoding: data, as: UTF8.self)

            // Parsen der Ausgabe und Extrahieren der Beschreibung
            let tagDescription = output.components(separatedBy: "\n")
                .first { $0.hasPrefix("Tag: ") }
                .map { $0.replacingOccurrences(of: "Tag: ", with: "") }

            if let description = tagDescription {
                descriptions.append(description)
            }
        }

        // Handler, der aufgerufen wird, wenn der Task beendet wurde
        task.terminationHandler = { _ in
            // Rückgabe der Beschreibung über den completion-Handler
            completion(descriptions.first)
        }
    }

    /// Druckt alle Branches und Tags eines Git-Repos aus.
    func printAll() {
        // URL des Git-Repos
        let url = URL(string: "https://github.com/carbon-language/carbon-lang.git")!

        // Abrufen der Branches
        guard let branches = getBranches(fromURL: url) else {
            fatalError("Fehler beim Abrufen der Branches")
        }

        // Für jeden Branch die Tags abrufen und ausgeben
        for branch in branches {
            print("Branch: \(branch)")

            guard let tags = getTags(forBranch: branch, fromURL: url) else {
                fatalError("Fehler beim Abrufen der Tags für Branch \(branch)")
            }

            for tag in tags {
                print(" \(tag)")

                getTagDescription(forTag: tag, fromURL: url) { description in
                    if let description = description {
                        print("  \(description)")
                    }
                }
            }
        }
    }

    /// Liest Daten aus einem Pipe und gibt sie als String-Liste zurück.
    ///
    /// - Parameter pipe: Das Pipe, aus dem die Daten gelesen werden sollen.
    /// - Returns: Eine String-Liste mit den gelesenen Daten oder nil im Fehlerfall.
    func readLinesFromPipe(_ pipe: Pipe) -> [String]? {
        // FileHandle zum Lesen aus dem Pipe
        let fileHandle = pipe.fileHandleForReading

        // Daten aus dem Pipe lesen
        guard let data = try? fileHandle.readToEnd() else {
            return nil
        }

        // Daten in String konvertieren
        let output = String(decoding: data, as: UTF8.self)

        // String in Zeilen zerlegen
        let lines = output.components(separatedBy: "\n")

        // Rückgabe der Zeilen als String-Liste
        return lines
    }
}
