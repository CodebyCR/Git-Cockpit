import Foundation

enum GitConfigError: Error {
    case fileNotFound, parsing
}

class GitConfig {
    let repoRootPath: URL
    let path: String
    private var configDictionary: [String: [String: String]] = [:]

    init?(atPath path: String) {
        self.path = path
        self.repoRootPath = URL(string: path)!.deletingLastPathComponent().deletingLastPathComponent()
        parseData()
    }

    // MARK: STATIC

    public static func parse(from path: String, completion: @escaping (Result<GitConfig, GitConfigError>) -> Void) {
        let fileManager = FileManager.default
        let saferPath = path.replacingOccurrences(of: "%20", with: " ")

        // Prüfen, ob die Datei existiert
        guard fileManager.fileExists(atPath: saferPath) else {
            completion(.failure(GitConfigError.fileNotFound))
            return
        }

        if let gitConfig = GitConfig(atPath: saferPath) {
            completion(.success(gitConfig))
        } else {
            completion(.failure(GitConfigError.parsing))
        }
    }

    // MARK: PUBLIC

    public func getValue(forKey key: String) -> [String: String]? {
        if let valueDictionary = configDictionary[key] {
            return valueDictionary
        }
        return nil
    }

    public func forEach(_ body: (String, [String: String]) -> Void) {
        for (section, sectionData) in configDictionary {
            body(section, sectionData)
        }
    }

    public func prettyPrint() {
        forEach { section, map in
            print("[\(section)]")
            for (key, value) in map {
                print("\t\(key) : \(value)")
            }
        }
    }

    public static func getFailureDescription(_ error: GitConfigError) -> String {
        switch error {
        case .fileNotFound:
            return "File could not be found."
        case .parsing:
            return "File content cannot be parsed."
        }
    }

    public func getOriginURL() -> URL? {
        if let remoteUrl = configDictionary[#"remote "origin""#]?["url"] {
            return URL(string: remoteUrl)
        }
        return nil
    }

    public func getOriginURL() -> String? {
        return getOriginURL()?.lastPathComponent
    }

    public func getRepoName() -> String? {
        return getOriginURL()?.absoluteString
    }

    public func getRepoRootPath() -> URL {
        return repoRootPath
    }

    // MARK: PRIVATE

    private func readFile(atPath path: String) -> String? {
        do {
            let contents = try String(contentsOfFile: path, encoding: .utf8)
            return contents
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }

    private func parseData() {
        var currentSection: String?

        if let configData = readFile(atPath: path) {
            for line in configData.components(separatedBy: "\n") {
                if line.hasPrefix("["), line.hasSuffix("]") {
                    currentSection = parseSectionHeader(line)
                    configDictionary[currentSection!] = [:]
                } else if let section = currentSection {
                    parseKeyValue(line, inSection: section)
                }
            }
        }
    }

    private func parseSectionHeader(_ line: String) -> String {
        let section = line.trimmingCharacters(in: .whitespaces)
        return String(section.dropFirst().dropLast())
    }

    private func parseKeyValue(_ line: String, inSection section: String) {
        let components = line.components(separatedBy: "=")
        if components.count == 2 {
            let key = components[0].trimmingCharacters(in: .whitespaces)
            let value = components[1].trimmingCharacters(in: .whitespaces)
            configDictionary[section]![key] = value
        }
    }
}
