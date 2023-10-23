import Foundation

enum GitConfigError: Error {
    case fileNotFound, parsing, valueNotFound
}

enum ConfigSection: String {
    case core, submodule, lfs
}

class GitConfig {
    let path: String
    private var configDictionary: [String: [String: String]] = [:]

    init(atPath path: URL) {
        self.path = path.path()
        parseData()

        print("configDictionary size: \(configDictionary.count)\n \(configDictionary)")
    }

    // MARK: PUBLIC

//    public func getParsingResult() -> Result<[String: [String: String]], GitConfig> {
//        if dontExistis() {
//            return .failure(GitConfig.fileNotFound)
//        }
//
//        do {
//            parseData()
//            return .success(configDictionary)
//        } catch {
//            return .failure(GitConfig.parsing)
//        }
//    }

    public func getValue(forKey key: String) -> [String: String]? {
        if let valueDictionary = configDictionary[key] {
            return valueDictionary
        }
        return nil
    }

    public func forEach(_ body: ([String: String]) -> Void) {
        for (_, sectionData) in configDictionary {
            body(sectionData)
        }
    }

    public func prettyPrint() {
        forEach { map in
            print("[\(map)]")
            for pair in map {
                print("\t\(pair.key) : \(pair.value)")
            }
        }
    }

    // MARK: PRIVATE

    private func dontExistis() -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: path)
    }

    private func parseData() {
        var currentSection: String?

        if let configData = try? String(contentsOfFile: path, encoding: .utf8) {
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
