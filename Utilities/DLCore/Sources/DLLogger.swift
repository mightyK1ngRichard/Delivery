//
// Created by Dmitriy Permyakov on 20.08.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import Foundation

public final class DLLogger: Sendable {

    let title: String

    public init(_ title: String) {
        self.title = title
    }

    public func info(_ message: Any, function: String = #function, line: Int = #line) {
        #if DEBUG
            print("ℹ️ [ \(title) ]: \(String(describing: function.split(separator: "(").first ?? "")): #\(line): \(message)")
        #endif
    }

    public func logEvent(function: String = #function, line: Int = #line) {
        #if DEBUG
            print("[ \(title) ]: \(String(describing: function.split(separator: "(").first ?? ""))")
        #endif
    }

    public func error(_ message: Any, function: String = #function, line: Int = #line) {
        #if DEBUG
            print("⛔️ [ \(title) ]: \(String(describing: function.split(separator: "(").first ?? "")): #\(line)")
            print(message)
        #endif
    }
}
