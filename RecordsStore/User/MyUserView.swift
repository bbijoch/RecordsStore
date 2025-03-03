//
//  MyUserView.swift
//  RecordsStore
//
//  Created by Bernard Bijoch on 02/03/2025.
//

import SwiftUI

struct MyUserView: View {
    @ObservedObject var viewModel: MyUserViewModel

    var body: some View {
        VStack {
            if let user = viewModel.user {
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .shadow(radius: 10)

                    Text(user.username.prefix(1).uppercased())
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(.top, 40)

                Text(user.username)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)

                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)

                Button(action: viewModel.logout) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 20)

                Spacer()
            } else {
                Text("User not logged in")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(hex: "de6262"), Color(hex: "ffb88c")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}
