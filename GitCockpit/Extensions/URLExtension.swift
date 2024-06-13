//
//  URLExtension.swift
//  Git Cockpit
//
//  Created by Christoph Rohde on 13.06.24.
//

import Foundation

public extension URL {
    static func / (firstPart: borrowing URL, pathPart: borrowing String) -> URL {
        return firstPart.appendingPathComponent(pathPart)
    }
}
