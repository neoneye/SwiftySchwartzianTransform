// MIT license. Copyright © 2017 Simon Strandgaard. All rights reserved.
import XCTest
@testable import SwiftySchwartzianTransform

enum RecordSortKey {
	case textAndId(text: String, id: Int)
	case id(id: Int)
}

extension RecordSortKey: Equatable {
	static func == (lhs: RecordSortKey, rhs: RecordSortKey) -> Bool {
		switch (lhs, rhs) {
		case let (.textAndId(text0, id0), .textAndId(text1, id1)):
			return text0 == text1 && id0 == id1
		case (.textAndId, .id):
			return false
		case (.id, .textAndId):
			return false
		case let (.id(id0), .id(id1)):
			return id0 == id1
		}
	}
}

extension RecordSortKey: Comparable {
	static func < (lhs: RecordSortKey, rhs: RecordSortKey) -> Bool {
		switch (lhs, rhs) {
		case let (.textAndId(text0, id0), .textAndId(text1, id1)):
			if text0 == text1 {
				return id0 < id1
			} else {
				return text0 < text1
			}
		case (.textAndId, .id):
			return true
		case (.id, .textAndId):
			return false
		case let (.id(id0), .id(id1)):
			return id0 < id1
		}
	}
}

extension RecordSortKey: CustomStringConvertible {
	var description: String {
		switch self {
		case let .textAndId(text, id):
			return "\(id);\(text)"
		case let .id(id):
			return "\(id);NIL"
		}
	}
}


struct Record {
	let id: Int
	let text: String?
}

extension Record {
	static func sorted(_ records: [Record], reverse: Bool) -> [Record] {
		typealias ST = SchwartzianTransform<Record, RecordSortKey>
		let st = ST(records, reverse: reverse) { (_, record) -> RecordSortKey in
			if let text = record.text?.lowercased() {
				return RecordSortKey.textAndId(text: text, id: record.id)
			} else {
				return RecordSortKey.id(id: record.id)
			}
		}
		print(st)
		return st.result
	}
}


class SchwartzianTransformTests: XCTestCase {
    func testBasic() {
		let allRecords: [Record] = [
			Record(id: 5, text: "B"),
			Record(id: 0, text: "A"),
			Record(id: 7, text: nil),
			Record(id: 1, text: "a"),
			Record(id: 6, text: nil),
			Record(id: 3, text: "B"),
			Record(id: 8, text: nil),
			Record(id: 4, text: "b"),
			Record(id: 2, text: "A"),
		]
		
		do {
			let records = Record.sorted(allRecords, reverse: false)
			let ids: [Int] = records.map { $0.id }
			XCTAssertEqual(ids, [0, 1, 2, 3, 4, 5, 6, 7, 8])
			let texts: [String] = records.map { $0.text ?? "NIL" }
			XCTAssertEqual(texts, ["A", "a", "A", "B", "b", "B", "NIL", "NIL", "NIL"])
		}
		do {
			let records = Record.sorted(allRecords, reverse: true)
			let ids: [Int] = records.map { $0.id }
			XCTAssertEqual(ids, [8, 7, 6, 5, 4, 3, 2, 1, 0])
			let texts: [String] = records.map { $0.text ?? "NIL" }
			XCTAssertEqual(texts, ["NIL", "NIL", "NIL", "B", "b", "B", "A", "a", "A"])
		}
    }

	func testEmpty() {
		let allRecords = [Record]()
		do {
			let records = Record.sorted(allRecords, reverse: false)
			XCTAssertTrue(records.isEmpty)
		}
		do {
			let records = Record.sorted(allRecords, reverse: true)
			XCTAssertTrue(records.isEmpty)
		}
	}

    static var allTests = [
        ("testBasic", testBasic),
        ("testEmpty", testEmpty),
    ]
}
