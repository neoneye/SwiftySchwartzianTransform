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
    
    // ... Sort using a SwiftySchwartzianTransform ...
    
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

