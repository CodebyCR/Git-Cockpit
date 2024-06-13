//
//  FilePathExtension.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 13.06.24.
//

import System

public extension FilePath {
    static func / (firstPart: FilePath, pathPart: FilePath) -> FilePath {
        return firstPart.appending(pathPart.components)
    }
}
