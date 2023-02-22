import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Інформація про зустріч"))  {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Старт зустрічі", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Тривалість", systemImage: "clock")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    Spacer()
                    Text("\(scrum.lengthInMinutes) хв")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Палітра", systemImage: "paintpalette")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                    
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Учасники")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("Історія")) {
                if scrum.history.isEmpty {
                    Label("Наразі поєдинків немає", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) {history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Редагувати") {
                isPresentingEditView = true
                data = scrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Скасувати") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Готово") {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}

