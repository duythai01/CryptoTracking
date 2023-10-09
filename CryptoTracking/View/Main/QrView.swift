//
//  QrView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct QrView: View {
    let test = ["sdadasdasdas", "sdaaaa", "asdadada", "asdaasaa"]

    @State var selection = "sdadasdasdas"

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                ExtractedView(content: test, selection: $selection)
            }

        }
    }
}

struct QrView_Previews: PreviewProvider {
    static var previews: some View {
        QrView()
    }
}

struct ExtractedView: View {
    var content: [String]
    @Binding var selection: String
    @State private var isExpanded: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text("Selected Option: \(selection)")
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                ForEach(content, id: \.self) { option in
                    Button(action: {
                        selection = option
                        isExpanded = false
                    }) {
                        Text(option)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .padding()
        .border(Color.gray, width: 1)
    }

    @ViewBuilder
    func RowView(_ title: String, _ size: CGSize) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background(
                VStack {
                    if selection == title {
                        Rectangle()
                            .fill(Color.red)
                    }
                }
            )
    }
}
