import SwiftUI

struct SmallSizeView: View {
    var entry: Provider.Entry
    var body: some View {
        return AnyView(
            VStack(alignment: .center) {
                Image("najia_logo")
                    .resizable()
                    .frame(width: 20, height: 12)
                    .padding(.bottom, 10)
                Text("Indeed, prayer prohibits immorality and wrongdoing.")
                    .font(.system(size: 9))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                Text("Al-Ankabut: 45")
                    .font(.system(size: 8))
                    .multilineTextAlignment(.center)
            }
        )
    }
}
