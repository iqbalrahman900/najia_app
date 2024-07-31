import SwiftUI

struct LargeSizeView: View {
    var entry: Provider.Entry
    var body: some View {
        return AnyView(
            VStack(alignment: .center) {
                Image("najia_logo")
                    .resizable()
                    .frame(width: 20, height: 12)
                    .padding(.bottom, 10)
                Text("Order your people to pray, and pray steadfastly yourself. We are not asking you to give Us provision;We provide for you, and the rewards of the Hereafter belong to the devout.")
                    .font(.system(size: 10))
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.center)
                Text("Taha: 132")
                    .font(.system(size: 8))
                    .multilineTextAlignment(.center)
            }
        )
    }
}
