# Schwartzian Transform (MIT license)

### Advanced sorting 

What is a Schwartzian Transform?

https://en.wikipedia.org/wiki/Schwartzian_transform


# Usecase

    let input = [
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
    
    // Sorting challenge:
    // Lowercase compare `text` fields.
    // When text is the same or nil, then fallback using the `id` field.
    
    let output = [
        Record(id: 0, text: "A"),
        Record(id: 1, text: "a"),
        Record(id: 2, text: "A"),
        Record(id: 3, text: "B"),
        Record(id: 4, text: "b"),
        Record(id: 5, text: "B"),
        Record(id: 6, text: nil),
        Record(id: 7, text: nil),
        Record(id: 8, text: nil),
    ]

With big classes then things gets messy. This is what a Schwartzian Transform is good at.

However with this simple `Record` class then one can use Apple's `Collection.sorted` function, like this:

    let output = input.sorted(by: { (lhs, rhs) -> Bool in
        if let text0 = lhs.text?.lowercased(), let text1 = rhs.text?.lowercased() {
            if text0 == text1 {
                return lhs.id < rhs.id
            }
            return text0 < text1
        }
        if lhs.text == nil, rhs.text == nil {
            return lhs.id < rhs.id
        }
        return lhs.text != nil
    })

The same looks like this with a Schwartzian Transform.

    import SwiftySchwartzianTransform
    // ...
    func sort(_ records: [Record]) -> [Record] {
        typealias ST = SchwartzianTransform<Record, RecordSortKey>
        let st = ST(records, reverse: false) { (_, record) -> RecordSortKey in
            if let text = record.text?.lowercased() {
                return RecordSortKey.textAndId(text: text, id: record.id)
            } else {
                return RecordSortKey.id(id: record.id)
            }
        }
        print(st)
        return st.result
    }
    // ...
    let output = sort(input)

Please see the unittest code for this full usecase.
