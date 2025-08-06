import Foundation

public protocol Cachable: Sendable {

    func fetchFromStoreOrNetwork<T>(storage: CacheStore<T>, request: () async throws -> T) async throws -> T
    func clearStorage() async
}

extension Cachable {

    public func fetchFromStoreOrNetwork<T>(storage: CacheStore<T>, request: () async throws -> T) async throws -> T {
        // Извлекаем кэш и флаг необходимости обновления
        let (cache, shouldUpdate) = await storage.value

        // Если кэша нет — загружаем новое значение
        guard let cache else {
            return try await request()
        }

        // Если кэш актуален — возвращаем его
        guard shouldUpdate else {
            return cache
        }

        // Иначе — обновляем кэш через request
        return try await request()
    }

    public func clearStorage() async {}
}
