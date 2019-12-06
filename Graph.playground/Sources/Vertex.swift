import Foundation

public struct Vertex<T> {
    public let index: Int
    public let data: T
    
    public init(index: Int, data: T) {
        self.index = index
        self.data = data
    }
}

extension Vertex: Hashable where T: Hashable { }
extension Vertex: Equatable where T: Equatable { }

extension Vertex: CustomStringConvertible {
    public var description: String {
        "\(index): \(data)"
    }
}
