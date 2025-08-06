import Foundation

extension CacheStore {

    private struct Cache {
        let value: T
        let date: Date
    }
}

public actor CacheStore<T> where T: Sendable {

    private let cacheLifeTimeSeconds: TimeInterval
    private var cache: Cache?

    public init(cacheLifeTimeSeconds: TimeInterval = 60) {
        self.cacheLifeTimeSeconds = cacheLifeTimeSeconds
    }

    public func set(_ newValue: T?) {
        if let newValue {
            // Сохраняем новое значение с текущей меткой времени
            cache = Cache(value: newValue, date: .now)
        } else {
            // Очищаем кэш
            cache = nil
        }
    }

    public var value: (value: T?, shouldUpdate: Bool) {
        guard let cache else { return (nil, true) }

        // Вычисляем, сколько времени прошло с момента кэширования
        let timeDiff = Date().timeIntervalSince(cache.date)

        // Если время жизни кэша истекло, возвращаем значение и флаг обновления
        guard timeDiff <= cacheLifeTimeSeconds else {
            return (cache.value, true)
        }

        return (cache.value, false)
    }
}
