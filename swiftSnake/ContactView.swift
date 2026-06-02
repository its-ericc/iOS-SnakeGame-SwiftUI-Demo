//
//  ContactView.swift
//  swiftSnake
//
//  Created by Eric Clark on 7/10/25.
//

import SwiftUI

//simple contact View
struct ContactView: View {
    var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.accentColor)
                        .padding(.top)

                    Text("About the Creator")
                        .font(.largeTitle)
                        .bold()

                    Text("Hi! I'm Eric Clark, the developer of this Snake game. I'm a passionate iOS developer and cat & dog sitter based in Pennsylvania. I created this app to learn about IOS development, grow as a developer, and share a fun project with the world.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("US: 123-456-7891")
                        }

                        HStack {
                            Image(systemName: "location.fill")
                            //Text("1200 Western House Road\nSan Pablo, California")
                            Text("520 Chestnut Street, Philadelphia, PA. 19106")
                        }
                    }
                    .padding()
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Contact")
        }
    }

#Preview {
    ContactView()
}
