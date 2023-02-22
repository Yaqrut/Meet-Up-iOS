import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    
    init (id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .magenta
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
    mutating func update(from data: Data) {
      title = data.title
      attendees = data.attendees
      lengthInMinutes = Int(data.lengthInMinutes)
      theme = data.theme
    }
  }


extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["Катя", "Дарья", "Семен", "Евгений"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Карина", "Сергей", "Жанна", "Лев", "Дарина"], lengthInMinutes: 5, theme: .seafoam),
        DailyScrum(title: "Web Dev", attendees: ["Юлия", "Коля", "Кристина", "Антон", "Роман", "Клара", "Людмила", "Ада", "Юрий", "Женя", "Петр"], lengthInMinutes: 8, theme: .indigo)
    ]
}
