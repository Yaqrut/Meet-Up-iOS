import SwiftUI

struct DetailEditView: View {
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Информація про зустріч")) {
                TextField("Назва", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Тривалість")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) хвилин")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) хвилин")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Учасники")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("Новий учасник", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Додати учасника")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
