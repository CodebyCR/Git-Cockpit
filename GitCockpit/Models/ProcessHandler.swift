//
//  ProcessHandler.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 20.10.23.
//

import Foundation
struct ProcessHandler {
    static func execute(task: Process) {
        let pipe = Pipe()
        task.standardOutput = pipe

        task.launch()
        task.waitUntilExit()
    }
}
