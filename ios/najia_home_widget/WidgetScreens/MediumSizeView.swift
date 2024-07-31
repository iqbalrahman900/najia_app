//
//  MediumSizeView.swift
//  najia_home_widgetExtension
//
//  Created by zvhir on 03/11/2023.
//

import SwiftUI

struct MediumSizeView: View {
    var entry: Provider.Entry
    var body: some View {
        return AnyView(
            VStack(alignment: .center) {
                Image("najia_logo")
                    .resizable()
                    .frame(width: 20, height: 12)
                    .padding(.bottom, 10)
                Text("Establish Prayer and pay Zakah and obey the Messenger so that mercy may be shown to you.")
                    .font(.system(size: 12))
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                Text("An-Nur: 56")
                    .font(.system(size: 10))
                    .multilineTextAlignment(.center)
            }
        )
    }
}
