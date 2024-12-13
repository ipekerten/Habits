//
//  SphereView.swift
//  Habits
//
//  Created by Ipek Erten on 11/12/24.
//

import SwiftUI
import SceneKit

struct SphereView: View {
    
    var body: some View {
        ZStack {
            // Background 3D Scene
            SceneView(
                scene: {
                    let scene = SCNScene(named: "baffo.scn")!

                    // Remove the default background
                    scene.background.contents = nil

                    let cameraNode = SCNNode()
                    cameraNode.camera = SCNCamera()
                    cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
                    scene.rootNode.addChildNode(cameraNode)

                    // Add ambient light for overall illumination
                    let ambientLightNode = SCNNode()
                    ambientLightNode.light = SCNLight()
                    ambientLightNode.light?.type = .ambient
                    ambientLightNode.light?.intensity = 500  // Ambient light intensity
                    scene.rootNode.addChildNode(ambientLightNode)

                    // Add multiple directional lights from different angles
                    let directionalLightNode1 = SCNNode()
                    directionalLightNode1.light = SCNLight()
                    directionalLightNode1.light?.type = .directional
                    directionalLightNode1.light?.intensity = 1000  // Adjust intensity
                    directionalLightNode1.position = SCNVector3(x: 5, y: 5, z: 5)  // First light positioned at diagonal angle
                    directionalLightNode1.eulerAngles = SCNVector3(x: -Float.pi / 4, y: 0, z: 0) // Angle for better illumination
                    scene.rootNode.addChildNode(directionalLightNode1)

                    // Second directional light from a different angle to fill shadows
                    let directionalLightNode2 = SCNNode()
                    directionalLightNode2.light = SCNLight()
                    directionalLightNode2.light?.type = .directional
                    directionalLightNode2.light?.intensity = 800  // Lower intensity
                    directionalLightNode2.position = SCNVector3(x: -5, y: 5, z: 5)  // Second light positioned at another diagonal
                    directionalLightNode2.eulerAngles = SCNVector3(x: Float.pi / 4, y: 0, z: 0) // Adjust angle
                    scene.rootNode.addChildNode(directionalLightNode2)

                    // Add continuous rotation animation
                    let rotationAction = SCNAction.rotateBy(x: 0, y: CGFloat.pi * 2, z: 0, duration: 10)
                    let repeatAction = SCNAction.repeatForever(rotationAction)
                    scene.rootNode.runAction(repeatAction)

                    // Add fade-in animation when the scene appears
                    scene.rootNode.opacity = 0  // Initially set opacity to 0 (invisible)
                    let fadeInAction = SCNAction.fadeIn(duration: 1)  // Fade in over 2 seconds
                    scene.rootNode.runAction(fadeInAction)

                    // Enable shadows on the scene for realism
                    scene.rootNode.castsShadow = true
                    for node in scene.rootNode.childNodes {
                        node.castsShadow = true
                    }

                    return scene
                }(),
                options: [.allowsCameraControl]
            )
            .ignoresSafeArea() // Make the SceneView fill the screen
            .onAppear {
                // Start any other animations or actions when the view appears
                print("3D Scene view appeared!")
            }

            // Foreground UI elements
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

                
                //Icon Bar
                HStack(spacing: 15) {
                    ForEach(1...7, id: \.self) { _ in
                        Button(action: {
                            // Action when the icon button is tapped
                            print("Icon tapped")
                        }) {
                            Image(systemName: "circle.fill") // Replace with any icon you prefer
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color(red: 98/255, green: 0/255, blue: 224/255))
                                .shadow(radius: 5)
                        }
                        .buttonStyle(PlainButtonStyle()) // Prevents the default button styling
                    }
                }

                .padding(.bottom, 3)
            }
        }
    }
}

// Preview for SwiftUI canvas
struct SphereView_Previews: PreviewProvider {
    static var previews: some View {
        SphereView()
    }
}