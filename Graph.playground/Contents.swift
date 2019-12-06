import Foundation

enum EdgeType {
    case directed
    case undirected
}


protocol Graph {
    associatedtype Element
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func addUndirectedEdgr(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

// Graph Implementation - Adjacency List: Each vertex stores the set of outgoing vertex

class AdjacencyList<T: Hashable>: Graph {
    
    var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    
    init() {
    }
    
    typealias Element = T
    
    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencies[source]?.append(edge)
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source).first {
            $0.destination == destination
        }?.weight
    }
}

extension Graph {
    func addUndirectedEdgr(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdgr(between: source, and: destination, weight: weight)
        }
    }
}

extension AdjacencyList: CustomStringConvertible {
    var description: String {
        var result = ""
        for (vertex, edges) in adjacencies {
            var edgesString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgesString.append("\(edge.destination), ")
                } else {
                    edgesString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [\(edgesString)]\n")
        }
        return result
    }
}

let graph = AdjacencyList<String>()
let singapore = graph.createVertex(data: "singapore")
let tokyo = graph.createVertex(data: "tokyo")
let hongKong = graph.createVertex(data: "hong kong")
let detroit = graph.createVertex(data: "detroit")
let sanFrancisco = graph.createVertex(data: "san francisco")
let washington = graph.createVertex(data: "washington")
let seattle = graph.createVertex(data: "seattle")

graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.add(.undirected, from: hongKong, to: washington, weight: 750)
graph.add(.undirected, from: tokyo, to: seattle, weight: 450)
graph.add(.undirected, from: seattle, to: detroit, weight: 100)
graph.add(.undirected, from: washington, to: sanFrancisco, weight: 150)


print(graph)

print("Outgoing flights from singapore")

for edge in graph.edges(from: singapore) {
    if let cost = graph.weight(from: edge.source, to: edge.destination) {
        print("from: \(edge.source.data) to: \(edge.destination.data), cost: $\(cost)")
    }
}
