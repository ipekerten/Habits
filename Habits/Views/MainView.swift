//
//  MainView.swift
//  Habits
//
//  Created by Ipek Erten on 04/12/24.
//

import SwiftUI

struct MainView: View {
    @State private var isHabitLogged = false
    @State private var navigateToSphereView = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack {
                    // App title with top-right button
                    ZStack {
                        Text("READ")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding()

                        HStack {
                            Spacer()
                            Button {
                                print("Top right button tapped")
                            } label: {
                                Image(systemName: "circle")
                                    .font(.title)
                                    .foregroundColor(
                                        Color(red: 98 / 255, green: 0 / 255, blue: 224 / 255)
                                    )
                                    .padding()
                            }
                        }
                    }

                    Spacer()

                    // Central animated button
                    Button {
                        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
                        impactFeedback.impactOccurred()

                        withAnimation(
                            .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
                        ) {
                            isHabitLogged.toggle()
                            if isHabitLogged {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    navigateToSphereView = true
                                }
                            }
                        }
                    } label: {
                        Image(isHabitLogged ? "ButtonDone" : "Button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isHabitLogged ? 300 : 280, height: isHabitLogged ? 300 : 280)
                            .foregroundColor(.white)
                            .cornerRadius(isHabitLogged ? 300 : 280)
                            .shadow(radius: 2)
                            .overlay(
                                Text(isHabitLogged ? "" : "READ")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                    }

                    Spacer()

                    // Dynamically aligned weekdays
                    HStack(spacing: 15) {
                        ForEach(daysForCurrentWeek()) { day in
                            VStack(spacing: 5) {
                                Button {
                                    print("Day \(day.number) tapped")
                                } label: {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(
                                            Color(red: 98 / 255, green: 0 / 255, blue: 224 / 255)
                                        )
                                        .shadow(radius: 3)
                                        .overlay(
                                            Text("\(day.number)")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        )
                                }
                                .buttonStyle(.plain)

                                // Day name text
                                Text(day.name)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
            .navigationDestination(isPresented: $navigateToSphereView) {
                SphereView()
            }
        }
    }
}




#Preview {
    MainView()
}
