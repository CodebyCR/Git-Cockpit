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

    static func executeWithStatus(task: Process) -> Int32 {
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()

        return task.terminationStatus
    }

    static func programIsInsalled(called programName: String) -> Bool {
        let programLookup = Process()
        programLookup.launchPath = "/usr/bin/which"
        programLookup.arguments = [programName]

        return executeWithStatus(task: programLookup) == 0
    }
}
