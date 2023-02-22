import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
            }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
            secondsRemaining / 60
        }
    
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(.linear)
                .tint(.yellow)
                .background(.blue)
            HStack {
                VStack(alignment: .leading) {
                    Text("Секунд Пройшло")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Секунд Залишилось")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Времени осталось")
            .accessibilityValue("\(minutesRemaining) минут")
        }
    }
}


struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 270, secondsRemaining: 180, theme: .purple)
            .previewLayout(.sizeThatFits)
    }
}
