//
//  MediumSizeLineView.swift
//  najia_home_widgetExtension
//
//  Created by zvhir on 03/11/2023.
//

import SwiftUI

struct MediumSizeLineView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Zohor")
                        .font(.system(size: 10))
                    Text("1:08PM")
                        .font(.system(size: 10))
                }
                ProgressView(value: 0.74)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                VStack(alignment: .leading) {
                    Text("Asar")
                        .font(.system(size: 10))
                        .bold()
                    Text("1:08PM")
                        .font(.system(size: 10))
                        .bold()
                }
            }
            .padding(.horizontal, 15)
            HStack {
                VStack(alignment: .center, spacing: 5) {
                    Text("Subuh")
                        .font(.system(size: 12))
                    Text("5:00AM")
                        .font(.system(size: 12))
                }
                VStack(alignment: .center, spacing: 5) {
                    Text("Zohor")
                        .font(.system(size: 12))
                    Text("5:00AM")
                        .font(.system(size: 12))
                }
                VStack(alignment: .center, spacing: 5) {
                    Text("Asar")
                        .font(.system(size: 12))
                        .bold()
                    Text("5:00AM")
                        .font(.system(size: 12))
                        .bold()
                }
                VStack(alignment: .center, spacing: 5) {
                    Text("Maghrib")
                        .font(.system(size: 12))
                    Text("5:00AM")
                        .font(.system(size: 12))
                }
                VStack(alignment: .center, spacing: 5) {
                    Text("Isha")
                        .font(.system(size: 12))
                    Text("5:00AM")
                        .font(.system(size: 12))
                }
            }
            .padding(.vertical, 10)
            HStack {
                if let formattedDate = formatEntryDate(entry.date) {
                    HStack{
                        Spacer()
                        Text("\(formattedDate), Kuala Lumpur")
                            .font(.system(size: 10))
                        Image("najia_logo")
                            .resizable()
                            .frame(width: 20, height: 12)
                        Spacer()
                    }
                }
            }
        }
    }
}
