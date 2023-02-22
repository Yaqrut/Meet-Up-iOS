

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Let's begin!")
            .font(.system(size: 40))
            .background(Color.yellow)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
