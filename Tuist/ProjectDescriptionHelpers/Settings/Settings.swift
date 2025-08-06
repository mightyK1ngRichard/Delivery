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
    }
}
