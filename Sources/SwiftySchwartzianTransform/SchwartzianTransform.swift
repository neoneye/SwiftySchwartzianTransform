// MIT license. Copyright © 2017 Simon Strandgaard. All rights reserved.

public struct SchwartzianTransform<T, C: Comparable> {
	public typealias Transform = (_ index: Int, _ element: T) throws -> C
	public typealias Pair = (C, T)
	
	public let unorderedPairs: [Pair]
	public let orderedPairs: [Pair]
	
	public init(_ elements: [T], reverse: Bool, transform: Transform) rethrows {
		var unordered = [Pair]()
		for (index, element) in elements.enumerated() {
			let compare: C = try transform(index, element)
			unordered.append((compare, element))
		}
		var ordered: [Pair] = unordered.sorted { $0.0 < $1.0 }
		if reverse {
			ordered.reverse()
		}
		self.unorderedPairs = unordered
		self.orderedPairs = ordered
	}
	
	public var result: [T] {
		return orderedPairs.map { $0.1 }
	}
}

extension SchwartzianTransform: CustomStringConvertible {
	public var description: String {
		let typeT = type(of: T.self)
		let typeC = type(of: C.self)
		let itemCount: Int = unorderedPairs.count
		let before: [C] = unorderedPairs.map { $0.0 }
		let after: [C] = orderedPairs.map { $0.0 }
		return "Sort \(itemCount) elements of \(typeT) by comparing \(typeC)\n\nbefore: \(before)\n\nafter: \(after)"
	}
}
