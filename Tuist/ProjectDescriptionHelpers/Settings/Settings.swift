import Foundation
import ProjectDescription

extension Settings {

    /// Базовые настройки проекта.
    public static func baseSettings(
        base: SettingsDictionary = [:],
        release: SettingsDictionary = [:],
        releaseXcconfig: Path? = nil,
        beta: SettingsDictionary = [:],
        betaXcconfig: Path? = nil,
        debug: SettingsDictionary = [:],
        debugXcconfig: Path? = nil
    ) -> Settings {
        .settings(
            base: .baseTargetSettings.merging(base)
        )
    }
}

extension SettingsDictionary {

    /// Базовые настройки таргетов для всех таргетов всех модулей и приложений.
    static var baseTargetSettings: SettingsDictionary {
        SettingsDictionary()
            .swiftVersion(TargetSettings.swiftVersion)
            .merging([
                "ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOL_EXTENSIONS": "YES",
                "ASSETCATALOG_COMPILER_GENERATE_ASSET_SYMBOLS": "YES",
                "DEFINES_MODULE": "NO",
                "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
                "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": "YES"
            ])
    }
}
