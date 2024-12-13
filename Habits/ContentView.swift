//
//  ContentView.swift
//  Habits
//
//  Created by Ipek Erten on 04/12/24.
//


import SwiftUI

struct ContentView: View {
    @State private var isHabitLogged = false // State variable to track button action
    @State private var navigateToSphereView = false // State variable to trigger navigation

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack {
                    ZStack {
                        // Centered app title
                        Text("READ")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding()

                        // Top-right button
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                print("Top right button tapped")
                            }) {
                                Image(systemName: "circle")
                                    .font(.title)
                                    .foregroundColor(Color(red: 98/255, green: 0/255, blue: 224/255))
                                    .padding()
                            }
                        }
                    }

                    Spacer()

                    Button(action: {
                        // Action when button is pressed
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)) {
                            isHabitLogged.toggle()
                            if isHabitLogged {
                                // Trigger a 1-second delay before navigating
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    navigateToSphereView = true
                                }
                            }
                        }
                    }) {
                        Image(isHabitLogged ? "ButtonDone" : "Button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: isHabitLogged ? 300 : 280, height: isHabitLogged ? 300 : 280)

                            .foregroundColor(.white)
                            .cornerRadius(isHabitLogged ? 300 : 280) // Smooth animation for size change
                            .shadow(radius: 2)
                            .overlay(
                                Text(isHabitLogged ? "" : "READ")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Spacer()

                    HStack(spacing: 15) {
                        
                        ForEach(1...7, id: \.self) { day in
                            VStack(spacing: 5) { // Stack the circle and day name vertically
                                Button(action: {
                                    // Action when the day button is tapped
                                    print("Day \(day) tapped")
                                }) {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color(red: 98/255, green: 0/255, blue: 224/255))
                                        .shadow(radius: 3)
                                        .overlay(
                                            Text("\(day)")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        )
                                }
                                .buttonStyle(PlainButtonStyle()) // Prevents the default button styling

                                // Day name text
                                Text(["THU", "FRI", "SAT", "SUN", "MON", "TUE", "TODAY"][day - 1])
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.bottom, 3)

                    // NavigationLink for the next view
                    NavigationLink(destination: SphereView()
                       // .navigationBarBackButtonHidden(true)
                                   , isActive: $navigateToSphereView) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

