//
// Created by Dmitriy Permyakov on 20.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import OSLog

public final class DLLogger: Sendable {

    private let title: String
    private let logger: Logger

    public init(_ title: String) {
        self.title = title
        self.logger = Logger(subsystem: title, category: "info")
    }

    public func info(_ message: Any, line: Int = #line) {
        #if DEBUG
            let msg = "[\(title)] #\(line) - \(String(describing: message))"
            logger.info("\(msg, privacy: .public)")
            print(msg)
        #endif
    }

    public func logEvent(line: Int = #line, function: String = #function) {
        #if DEBUG
            let msg = "[\(title)] Event at \(function) #\(line)"
            logger.debug("\(msg, privacy: .public)")
        #endif
    }

    public func error(_ message: Any, line: Int = #line, function: String = #function) {
        #if DEBUG
            let msg = "[\(title)] ERROR at \(function):#\(line) - \(String(describing: message))"
            logger.error("\(msg, privacy: .public)")
        #endif
    }
}
