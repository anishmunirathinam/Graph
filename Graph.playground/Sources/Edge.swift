import Foundation

public struct Edge<T> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
    
    public init(source: Vertex<T>, destination: Vertex<T>, weight: Double?) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }
}

