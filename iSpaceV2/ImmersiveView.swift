//
//  ImmersiveView.swift
//  iSpaceV2
//
//  Created by Spencer Luke on 1/29/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import simd

struct ImmersiveView: View {
    
    @ObservedObject var spaceData: SpaceData
    @State var sceneName = "spaceSB1"
    @State var rotation = Angle.radians(0)
    
    @State var planetIn = true
    @State var rocketIn = false
    @State var fictionIn = false
    
    var body: some View {
        RealityView { content in
            
            //add skybox
            let skyBoxMesh = MeshResource.generateSphere(radius: 1000)
            guard let skyBoxEntity = createSkyBox(name: sceneName, mesh: skyBoxMesh) else {
                print("error")
                return
            }
            content.add(skyBoxEntity)
            
            //variables for walls
            let userTransform = Transform.identity
            let distance: Float = 7.0
            let userPosition = userTransform.translation
            
            
            //special Floor
            let floorSpecial = ModelEntity(mesh: .generatePlane(width: 50, depth: 50), materials: [OcclusionMaterial()])
            floorSpecial.generateCollisionShapes(recursive: false)
            floorSpecial.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            floorSpecial.transform.rotation = simd_quatf(angle: .pi, axis: [0, 0, 0])
            floorSpecial.scale = SIMD3<Float>(10, 10, 10)
            floorSpecial.position.y = 50
            content.add(floorSpecial)
            
            //The floor
            let floor = ModelEntity(mesh: .generatePlane(width: 30, depth: 30), materials: [SimpleMaterial(color: .red, isMetallic: false)])
            floor.generateCollisionShapes(recursive: false)
            floor.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            floor.transform.rotation = simd_quatf(angle: .pi, axis: [1, 0, 0])
            floor.scale = SIMD3<Float>(1, 2, 1)
            content.add(floor)
        
            //[SimpleMaterial(color: .red, isMetallic: false)]
            
            //The roof
            let roof = ModelEntity(mesh: .generatePlane(width: 25, depth: 25), materials: [OcclusionMaterial()])
            roof.generateCollisionShapes(recursive: false)
            roof.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            roof.position.y = 10
            content.add(roof)
            
            //Wall 1
            let forwardDirection1 = userTransform.rotation.act([0, 0, -1])
            let spawnPosition1 = userPosition + forwardDirection1 * distance
            
            let wall1 = ModelEntity(mesh: .generatePlane(width: 20, depth: 20), materials: [OcclusionMaterial()])
            wall1.generateCollisionShapes(recursive: false)
            wall1.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            let rotation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0]) // 90 degree rotation around the y-axis
                        wall1.transform.rotation = rotation
            wall1.position = spawnPosition1
            wall1.transform.rotation *= simd_quatf(angle: .pi, axis: [0, 0, 1])
            content.add(wall1)
            
            //Wall 2
            let forwardDirection2 = userTransform.rotation.act([1, 0, 0])
            let spawnPosition2 = userPosition + forwardDirection2 * distance
            
            let wall2 = ModelEntity(mesh: .generatePlane(width: 20, depth: 20), materials: [OcclusionMaterial()])
            wall2.generateCollisionShapes(recursive: false)
            wall2.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            let rotation2 = simd_quatf(angle: .pi / 2, axis: [0, 0, 1]) // 90 degree rotation around the y-axis
                        wall2.transform.rotation = rotation2
            wall2.position = spawnPosition2
            wall2.transform.rotation *= simd_quatf(angle: .pi, axis: [0, 0, 1])
            content.add(wall2)
            
            //Wall 3
            let forwardDirection3 = userTransform.rotation.act([0, 0, 1])
            let spawnPosition3 = userPosition + forwardDirection3 * distance
            
            let wall3 = ModelEntity(mesh: .generatePlane(width: 20, depth: 20), materials: [OcclusionMaterial()])
            wall3.generateCollisionShapes(recursive: false)
            wall3.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            let rotation3 = simd_quatf(angle: .pi / 2, axis: [1, 0, 0]) // 90 degree rotation around the y-axis
                        wall3.transform.rotation = rotation3
            wall3.position = spawnPosition3
            content.add(wall3)
            
            //Wall 4
            let forwardDirection4 = userTransform.rotation.act([-1, 0, 0])
            let spawnPosition4 = userPosition + forwardDirection4 * distance
            
            let wall4 = ModelEntity(mesh: .generatePlane(width: 20, depth: 20), materials: [OcclusionMaterial()])
            wall4.generateCollisionShapes(recursive: false)
            wall4.components[PhysicsBodyComponent.self] = .init(
                massProperties: .default,
                mode: .static
            )
            let rotation4 = simd_quatf(angle: .pi / 2, axis: [0, 0, 1]) // 90 degree rotation around the y-axis
                        wall4.transform.rotation = rotation4
            wall4.position = spawnPosition4
            content.add(wall4)

            // Add the initial RealityKit content

            //===========================================================================//
                                            //PLANETS
            //===========================================================================//

            //SCALES
                //mercury - 1 - 0.5
                //venus - 3 - 1.5
                //earth - 3 (0.3) - 1.5
                //moon - 0.75 - 0.375
                //mars - 1.5
                //neptune - 11.64
                //uranus - 12
                //saturn - 28.35
                //jupiter - 33.6
            
            if let earthModel = try? await Entity(named: "earth3"),
               let earth = earthModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                earth.scale = [0.3,0.3,0.3]
                earth.position = SIMD3<Float>(0, 0.75, -2)
                
                await createObject(model: earth, moveable: true)

                //constant update
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((earth.position.z > 15) || (earth.position.z < -15)) ||
                        ((earth.position.x > 15) || (earth.position.x < -15))) {
                            earth.position = SIMD3<Float>(0, 0.75, -2)
                            givePhysics(model: earth)
                    }
                    if (spaceData.quizType != 0) {
                        earth.position = SIMD3<Float>(0, 55, -10)
                        earth.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((earth.position.y > 15) || (earth.position.y < -0.5)) {
                            earth.position = SIMD3<Float>(0, 0.75, -2)
                            givePhysics(model: earth)
                        }
                    }
                    
                    
                    var skyBoxMaterial = UnlitMaterial()
                    if (spaceData.sceneNum == 0 && spaceData.changescene) {
                        let skyBoxTexture = try? TextureResource.load(named: "spaceSB1")
                        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture!))
                        skyBoxEntity.components.set(
                            ModelComponent(
                                mesh: skyBoxMesh,
                                materials: [skyBoxMaterial]
                            )
                        )
                        spaceData.changescene = false
                    } else if (spaceData.sceneNum == 1 && spaceData.changescene) {
                        let skyBoxTexture = try? TextureResource.load(named: "spaceSB2")
                        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture!))
                        skyBoxEntity.components.set(
                            ModelComponent(
                                mesh: skyBoxMesh,
                                materials: [skyBoxMaterial]
                            )
                        )
                        spaceData.changescene = false
                    } else if (spaceData.sceneNum == 2 && spaceData.changescene) {
                        let skyBoxTexture = try? TextureResource.load(named: "spaceSB3")
                        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture!))
                        skyBoxEntity.components.set(
                            ModelComponent(
                                mesh: skyBoxMesh,
                                materials: [skyBoxMaterial]
                            )
                        )
                        spaceData.changescene = false
                    } else if (spaceData.sceneNum == 3 && spaceData.changescene) {
                        let skyBoxTexture = try? TextureResource.load(named: "spaceSB4")
                        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture!))
                        skyBoxEntity.components.set(
                            ModelComponent(
                                mesh: skyBoxMesh,
                                materials: [skyBoxMaterial]
                            )
                        )
                        spaceData.changescene = false
                    } else { }
                    
                    if(spaceData.quizType == 0) {
                        planetIn = true
                    }
                    if(spaceData.quizType == 1) {
                        rocketIn = true
                    }
                    if(spaceData.quizType == 2) {
                        fictionIn = true
                    }
                }
                
                content.add(earth)
            
            }
            
            if let moonModel = try? await Entity(named: "Moon"),
               let moon = moonModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                moon.scale = [0.75,0.75,0.75]
                moon.position = SIMD3<Float>(1, 0.75, -2)
                
                await createObject(model: moon, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((moon.position.z > 15) || (moon.position.z < -15)) ||
                        ((moon.position.x > 15) || (moon.position.x < -15))) {
                            moon.position = SIMD3<Float>(1, 0.75, -2)
                            givePhysics(model: moon)
                    }
                    if (spaceData.quizType != 0) {
                        //if not planets quiz > TP to top of world
                        moon.position = SIMD3<Float>(0, 55, -10)
                        moon.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((moon.position.y > 15) || (moon.position.y < -0.5)) {
                            moon.position = SIMD3<Float>(1, 0.75, -2)
                            givePhysics(model: moon)
                        }
                    }
                }
                
                content.add(moon)
            }
            if let marsModel = try? await Entity(named: "Mars"),
               let mars = marsModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                mars.scale = [1.5,1.5,1.5]
                mars.position = SIMD3<Float>(-1, 0.75, -2)

                await createObject(model: mars, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((mars.position.z > 15) || (mars.position.z < -15)) ||
                        ((mars.position.x > 15) || (mars.position.x < -15))) {
                            mars.position = SIMD3<Float>(-1, 0.75, -2)
                            givePhysics(model: mars)
                    }
                    if (spaceData.quizType != 0) {
                        mars.position = SIMD3<Float>(0, 55, -10)
                        mars.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((mars.position.y > 15) || (mars.position.y < -0.5)) {
                            mars.position = SIMD3<Float>(-1, 0.75, -2)
                            givePhysics(model: mars)
                        }
                    }
                }
                
                content.add(mars)
            }
            
            if let mercuryModel = try? await Entity(named: "Mercury"),
               let mercury = mercuryModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                mercury.scale = [1,1,1]
                mercury.position = SIMD3<Float>(2, 0.75, -2)
                
                await createObject(model: mercury, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((mercury.position.z > 15) || (mercury.position.z < -15)) ||
                        ((mercury.position.x > 15) || (mercury.position.x < -15))) {
                            mercury.position = SIMD3<Float>(2, 0.75, -2)
                            givePhysics(model: mercury)
                    }
                    if (spaceData.quizType != 0) {
                        mercury.position = SIMD3<Float>(0, 55, -10)
                        mercury.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((mercury.position.y > 15) || (mercury.position.y < -0.5)) {
                            mercury.position = SIMD3<Float>(2, 0.75, -2)
                            givePhysics(model: mercury)
                        }
                    }
                }
                content.add(mercury)
            }
            
            if let venusModel = try? await Entity(named: "Venus"),
               let venus = venusModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                venus.scale = [3,3,3]
                venus.position = SIMD3<Float>(-2, 0.75, -2)
                
                await createObject(model: venus, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((venus.position.z > 15) || (venus.position.z < -15)) ||
                        ((venus.position.x > 15) || (venus.position.x < -15))) {
                            venus.position = SIMD3<Float>(-2, 0.75, -2)
                            givePhysics(model: venus)
                    }
                    if (spaceData.quizType != 0) {
                        venus.position = SIMD3<Float>(0, 55, -10)
                        venus.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((venus.position.y > 15) || (venus.position.y < -0.5)) {
                            venus.position = SIMD3<Float>(-2, 0.75, -2)
                            givePhysics(model: venus)
                        }
                    }
                }
                content.add(venus)
            }
            
            if let jupiterModel = try? await Entity(named: "Jupiter"),
               let jupiter = jupiterModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                jupiter.scale = [8,8,8]
                jupiter.position = SIMD3<Float>(-3, 0.75, -4)
                
                await createObject(model: jupiter, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((jupiter.position.z > 15) || (jupiter.position.z < -15)) ||
                        ((jupiter.position.x > 15) || (jupiter.position.x < -15))) {
                            jupiter.position = SIMD3<Float>(-3, 0.75, -4)
                            givePhysics(model: jupiter)
                    }
                    if (spaceData.quizType != 0) {
                        jupiter.position = SIMD3<Float>(0, 55, -10)
                        jupiter.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((jupiter.position.y > 15) || (jupiter.position.y < -0.5)) {
                            jupiter.position = SIMD3<Float>(-3, 0.75, -4)
                            givePhysics(model: jupiter)
                        }
                    }
                }
                content.add(jupiter)
            }
            
            if let saturnModel = try? await Entity(named: "Saturn"),
               let saturn = saturnModel.children.first?.children.first?.children.first?.children.first?.children.first?.children[1] {
                saturn.scale = [6,6,6]
                saturn.position = SIMD3<Float>(3, 0.75, -4)
                
                await createObject(model: saturn, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((saturn.position.z > 15) || (saturn.position.z < -15)) ||
                        ((saturn.position.x > 15) || (saturn.position.x < -15))) {
                            saturn.position = SIMD3<Float>(3, 0.75, -4)
                            givePhysics(model: saturn)
                    }
                    if (spaceData.quizType != 0) {
                        saturn.position = SIMD3<Float>(0, 55, -10)
                        saturn.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((saturn.position.y > 15) || (saturn.position.y < -0.5)) {
                            saturn.position = SIMD3<Float>(3, 0.75, -4)
                            givePhysics(model: saturn)
                        }
                    }
                }
                content.add(saturn)
            }
            
            if let neptuneModel = try? await Entity(named: "Neptune"),
               let neptune = neptuneModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                neptune.scale = [4,4,4]
                neptune.position = SIMD3<Float>(-3, 0.75, -1)
                
                await createObject(model: neptune, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((neptune.position.z > 15) || (neptune.position.z < -15)) ||
                        ((neptune.position.x > 15) || (neptune.position.x < -15))) {
                            neptune.position = SIMD3<Float>(-3, 0.75, -1)
                            givePhysics(model: neptune)
                    }
                    if (spaceData.quizType != 0) {
                        neptune.position = SIMD3<Float>(0, 55, -10)
                        neptune.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((neptune.position.y > 15) || (neptune.position.y < -0.5)) {
                            neptune.position = SIMD3<Float>(-3, 0.75, -1)
                            givePhysics(model: neptune)
                        }
                    }
                }
                content.add(neptune)
            }
            
            if let uranusModel = try? await Entity(named: "Uranus"),
               let uranus = uranusModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                uranus.scale = [4,4,4]
                uranus.position = SIMD3<Float>(3, 0.75, -1)
                
                await createObject(model: uranus, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((uranus.position.z > 15) || (uranus.position.z < -15)) ||
                        ((uranus.position.x > 15) || (uranus.position.x < -15))) {
                            uranus.position = SIMD3<Float>(3, 0.75, -1)
                            givePhysics(model: uranus)
                    }
                    if (spaceData.quizType != 0) {
                        uranus.position = SIMD3<Float>(0, 55, -10)
                        uranus.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((uranus.position.y > 15) || (uranus.position.y < -0.5)) {
                            uranus.position = SIMD3<Float>(3, 0.75, -1)
                            givePhysics(model: uranus)
                        }
                    }
                }
                content.add(uranus)
            }
            
            //===========================================================================//
                                            //ROCKETS
            //===========================================================================//
            
            if let discoveryModel = try? await Entity(named: "discoveryCombFix"),
               let discovery = discoveryModel.children.first?.children.first {
                discovery.scale = [0.0003,0.0003,0.0003]
                discovery.position = SIMD3<Float>(-1.25, 2, -2)
                discovery.transform.rotation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
                
                await createObject(model: discovery, moveable: true)

                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((discovery.position.z > 15) || (discovery.position.z < -15)) ||
                        ((discovery.position.x > 15) || (discovery.position.x < -15))) {
                            discovery.position = SIMD3<Float>(-1.25, 2, -2)
                            givePhysics(model: discovery)
                    }
                    if (spaceData.quizType != 1) {
                        discovery.position = SIMD3<Float>(0, 55, -10)
                        discovery.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((discovery.position.y > 15) || (discovery.position.y < -0.5)) {
                            discovery.position = SIMD3<Float>(-1.25, 2, -2)
                            givePhysics(model: discovery)
                        }
                    }
                }
                
                content.add(discovery)
            }
            
            if let falconModel = try? await Entity(named: "falconCombFix"),
               let falcon = falconModel.children.first?.children.first{
                falcon.scale = [0.003,0.003,0.003]
                falcon.position = SIMD3<Float>(-1.5, 0.75, -2)
                falcon.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])
                
                await createObject(model: falcon, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((falcon.position.z > 15) || (falcon.position.z < -15)) ||
                        ((falcon.position.x > 15) || (falcon.position.x < -15))) {
                            falcon.position = SIMD3<Float>(-1.5, 0.75, -2)
                            givePhysics(model: falcon)
                    }
                    if (spaceData.quizType != 1) {
                        falcon.position = SIMD3<Float>(0, 55, -10)
                        falcon.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((falcon.position.y > 15) || (falcon.position.y < -0.5)) {
                            falcon.position = SIMD3<Float>(-1.5, 0.75, -2)
                            givePhysics(model: falcon)
                        }
                    }
                }
                
                content.add(falcon)
            }
            
            //DOESNT WORK
//            if let webbModel = try? await Entity(named: "webbComb"),
//               let webb = webbModel.children.first {
//                webb.scale = [0.0015,0.0015,0.0015]
//                webb.position = SIMD3<Float>(2, 0.75, -2)
//                webb.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 1])
//                
//                print(webb)
//                await createObject(model: webb, moveable: true)
//                
//                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
//                    if (((webb.position.z > 15) || (webb.position.z < -15)) ||
//                        ((webb.position.x > 15) || (webb.position.x < -15))) {
//                            webb.position = SIMD3<Float>(2, 0.75, -2)
//                            givePhysics(model: webb)
//                    }
//                    if (spaceData.quizType != 1) {
//                        webb.position = SIMD3<Float>(0, 55, -10)
//                        webb.components[PhysicsBodyComponent.self]?.mode = .kinematic
//                    } else {
//                        if ((webb.position.y > 15) || (webb.position.y < -0.5)) {
//                            webb.position = SIMD3<Float>(2, 0.75, -2)
//                            givePhysics(model: webb)
//                        }
//                    }
//                }
//                
//                content.add(webb)
//            }
            
            if let ISSModel = try? await Entity(named: "ISSCombFix"),
               let ISS = ISSModel.children.first?.children.first {
                ISS.scale = [0.0001,0.0001,0.0001]
                ISS.position = SIMD3<Float>(1.25, 1.75, -2)
                ISS.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])
                
                await createObject(model: ISS, moveable: true)

                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((ISS.position.z > 15) || (ISS.position.z < -15)) ||
                        ((ISS.position.x > 15) || (ISS.position.x < -15))) {
                            ISS.position = SIMD3<Float>(1.25, 1.75, -2)
                            givePhysics(model: ISS)
                    }
                    if (spaceData.quizType != 1) {
                        ISS.position = SIMD3<Float>(0, 55, -10)
                        ISS.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((ISS.position.y > 15) || (ISS.position.y < -0.5)) {
                            ISS.position = SIMD3<Float>(1.25, 1.75, -2)
                            givePhysics(model: ISS)
                        }
                    }
                }

                content.add(ISS)
            }

            if let sputnikModel = try? await Entity(named: "sputnikCombFix"),
               let sputnik = sputnikModel.children.first?.children.first{
                sputnik.scale = [0.0025,0.0025,0.0025]
                sputnik.position = SIMD3<Float>(1.25, 1, -2)
                sputnik.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])
                
                await createObject(model: sputnik, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((sputnik.position.z > 15) || (sputnik.position.z < -15)) ||
                        ((sputnik.position.x > 15) || (sputnik.position.x < -15))) {
                            sputnik.position = SIMD3<Float>(1, 1, -2)
                            givePhysics(model: sputnik)
                    }
                    if (spaceData.quizType != 1) {
                        sputnik.position = SIMD3<Float>(0, 55, -10)
                        sputnik.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((sputnik.position.y > 15) || (sputnik.position.y < -0.5)) {
                            sputnik.position = SIMD3<Float>(1, 1, -2)
                            givePhysics(model: sputnik)
                        }
                    }
                }
                
                content.add(sputnik)
            }
            
            if let saturnVModel = try? await Entity(named: "SaturnV"),
               let saturnV = saturnVModel.children.first?.children.first?.children.first?.children.first{
                saturnV.scale = [0.009,0.009,0.009]
                saturnV.position = SIMD3<Float>(-0.75, 0.75, -2)
                saturnV.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])
                
                await createObject(model: saturnV, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((saturnV.position.z > 15) || (saturnV.position.z < -15)) ||
                        ((saturnV.position.x > 15) || (saturnV.position.x < -15))) {
                            saturnV.position = SIMD3<Float>(-0.75, 0.75, -2)
                            givePhysics(model: saturnV)
                    }
                    if (spaceData.quizType != 1) {
                        saturnV.position = SIMD3<Float>(0, 55, -10)
                        saturnV.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((saturnV.position.y > 15) || (saturnV.position.y < -0.5)) {
                            saturnV.position = SIMD3<Float>(-0.75, 0.75, -2)
                            givePhysics(model: saturnV)
                        }
                    }
                }
                
                content.add(saturnV)
            }
            
            //===========================================================================//
                                            //FICTIONAL SHIPS
            //===========================================================================//
            
            if let borgModel = try? await Entity(named: "borgCombObj"),
               let borg = borgModel.children.first?.children.first {
                borg.scale = [0.0025,0.0025,0.0025]
                borg.position = SIMD3<Float>(1, 0.75, -2)

                await createObject(model: borg, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((borg.position.z > 15) || (borg.position.z < -15)) ||
                        ((borg.position.x > 15) || (borg.position.x < -15))) {
                        borg.position = SIMD3<Float>(1, 0.75, -2)
                            givePhysics(model: borg)
                    }
                    if (spaceData.quizType != 2) {
                        borg.position = SIMD3<Float>(0, 55, -10)
                        borg.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((borg.position.y > 15) || (borg.position.y < -0.5)) {
                            borg.position = SIMD3<Float>(1, 0.75, -2)
                            givePhysics(model: borg)
                        }
                    }
                }
                content.add(borg)
            }
            
            if let deathModel = try? await Entity(named: "deathComb"),
               let death = deathModel.children.first?.children.first?.children.first?.children.first?.children.first?.children.first?.children.first?.children.first?.children.first?.children.first {
                death.scale = [0.003,0.003,0.003]
                death.position = SIMD3<Float>(2, 1, -1.75)
                death.transform.rotation = simd_quatf(angle: .pi / 2, axis: [-1, 0, 0])
                
                await createObject(model: death, moveable: false)

                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((death.position.z > 15) || (death.position.z < -15)) ||
                        ((death.position.x > 15) || (death.position.x < -15))) {
                        death.position = SIMD3<Float>(2, 0.75, -2)
                    }
                    if (spaceData.quizType != 2) {
                        death.position = SIMD3<Float>(0, 55, -10)
                    } else {
                        if ((death.position.y > 15) || (death.position.y < -0.5)) {
                            death.position = SIMD3<Float>(2, 0.75, -2)
                        }
                    }
                }
                content.add(death)
            }
            
            if let enterpriseModel = try? await Entity(named: "EnterpriseCombObj"),
               let enterprise = enterpriseModel.children.first?.children.first {
                enterprise.scale = [0.002,0.002,0.002]
                enterprise.position = SIMD3<Float>(0, 0.75, -1.5)

                enterprise.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 1, 0])
                await createObject(model: enterprise, moveable: false)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((enterprise.position.z > 15) || (enterprise.position.z < -15)) ||
                        ((enterprise.position.x > 15) || (enterprise.position.x < -15))) {
                        enterprise.position = SIMD3<Float>(0, 0.75, -2.25)
                            givePhysics(model: enterprise)
                    }
                    if (spaceData.quizType != 2) {
                        enterprise.position = SIMD3<Float>(0, 55, -10)
                        enterprise.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((enterprise.position.y > 15) || (enterprise.position.y < -0.5)) {
                            enterprise.position = SIMD3<Float>(0, 0.75, -2.25)
                            givePhysics(model: enterprise)
                        }
                    }
                }
                
                content.add(enterprise)
            }
            
            if let tieModel = try? await Entity(named: "TieCombObj"),
               let tie = tieModel.children.first?.children.first {
                tie.scale = [0.003,0.003,0.003]
                tie.position = SIMD3<Float>(-2, 1, -2)

                await createObject(model: tie, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((tie.position.z > 15) || (tie.position.z < -15)) ||
                        ((tie.position.x > 15) || (tie.position.x < -15))) {
                        tie.position = SIMD3<Float>(-2, 0.75, -2)
                            givePhysics(model: tie)
                    }
                    if (spaceData.quizType != 2) {
                        tie.position = SIMD3<Float>(0, 55, -10)
                        tie.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((tie.position.y > 15) || (tie.position.y < -0.5)) {
                            tie.position = SIMD3<Float>(-2, 0.75, -2)
                            givePhysics(model: tie)
                        }
                    }
                }
                
                content.add(tie)
            }
            
            if let milleniumModel = try? await Entity(named: "millenniumCombFix"),
               let millenium = milleniumModel.children.first?.children.first {
                millenium.scale = [0.001,0.001,0.001]
                millenium.position = SIMD3<Float>(-2, 1.5, -2)
                millenium.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])
                
                await createObject(model: millenium, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((millenium.position.z > 15) || (millenium.position.z < -15)) ||
                        ((millenium.position.x > 15) || (millenium.position.x < -15))) {
                        millenium.position = SIMD3<Float>(-2, 1.5, -2)
                            givePhysics(model: millenium)
                    }
                    if (spaceData.quizType != 2) {
                        millenium.position = SIMD3<Float>(0, 55, -10)
                        millenium.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((millenium.position.y > 15) || (millenium.position.y < -0.5)) {
                            millenium.position = SIMD3<Float>(-2, 1.5, -2)
                            givePhysics(model: millenium)
                        }
                    }
                }
                
                content.add(millenium)
            }
            
            if let haloModel = try? await Entity(named: "haloComb"),
               let halo = haloModel.children.first?.children.first{
                halo.scale = [0.002,0.002,0.002]
                halo.position = SIMD3<Float>(1.5, 2, -2)
                halo.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])
                
                await createObject(model: halo, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((halo.position.z > 15) || (halo.position.z < -15)) ||
                        ((halo.position.x > 15) || (halo.position.x < -15))) {
                        halo.position = SIMD3<Float>(2, 2, -2)
                            givePhysics(model: halo)
                    }
                    if (spaceData.quizType != 2) {
                        halo.position = SIMD3<Float>(0, 55, -10)
                        halo.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((halo.position.y > 15) || (halo.position.y < -0.5)) {
                            halo.position = SIMD3<Float>(1.5, 2, -2)
                            givePhysics(model: halo)
                        }
                    }
                }
                
                content.add(halo)
            }
            
            if let tardisModel = try? await Entity(named: "tardisCombObj"),
               let tardis = tardisModel.children.first?.children.first {
                tardis.scale = [0.002,0.002,0.002]
                tardis.position = SIMD3<Float>(-2, 2.25, -2)
                tardis.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])

                await createObject(model: tardis, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((tardis.position.z > 15) || (tardis.position.z < -15)) ||
                        ((tardis.position.x > 15) || (tardis.position.x < -15))) {
                        tardis.position = SIMD3<Float>(-2, 2.25, -2)
                            givePhysics(model: tardis)
                    }
                    if (spaceData.quizType != 2) {
                        tardis.position = SIMD3<Float>(0, 55, -10)
                        tardis.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((tardis.position.y > 15) || (tardis.position.y < -0.5)) {
                            tardis.position = SIMD3<Float>(-2, 2.25, -2)
                            givePhysics(model: tardis)
                        }
                    }
                }
                
                content.add(tardis)
            }
            
            if let destroyerModel = try? await Entity(named: "destroyerCombObj"),
               let destroyer = destroyerModel.children.first?.children.first{
                destroyer.scale = [0.0025,0.0025,0.0025]
                destroyer.position = SIMD3<Float>(-0.5, 2.2, -2)
                destroyer.transform.rotation = simd_quatf(angle: .pi / 2, axis: [0, 0, 0])

                await createObject(model: destroyer, moveable: true)
                
                let _ = content.subscribe(to: SceneEvents.Update.self) { event in
                    if (((destroyer.position.z > 15) || (destroyer.position.z < -15)) ||
                        ((destroyer.position.x > 15) || (destroyer.position.x < -15))) {
                        destroyer.position = SIMD3<Float>(-0.5, 2.2, -2)
                            givePhysics(model: destroyer)
                    }
                    if (spaceData.quizType != 2) {
                        destroyer.position = SIMD3<Float>(0, 55, -10)
                        destroyer.components[PhysicsBodyComponent.self]?.mode = .kinematic
                    } else {
                        if ((destroyer.position.y > 15) || (destroyer.position.y < -0.5)) {
                            destroyer.position = SIMD3<Float>(-0.5, 2.2, -2)
                            givePhysics(model: destroyer)
                        }
                    }
                }
                
                content.add(destroyer)
            }
            
        }
        .gesture(dragGesture)
    }

    private func createSkyBox (name: String, mesh: MeshResource) -> Entity? {
        //mesh - put at top of code
        //Material
        var skyBoxMaterial = UnlitMaterial()
        
        guard let skyBoxTexture = try? TextureResource.load(named: name) else { return nil }
        skyBoxMaterial.color = .init(texture: .init(skyBoxTexture))
        //skybox entity
        let skyBoxEntity = Entity()
        skyBoxEntity.components.set(
            ModelComponent(
                mesh: mesh,
                materials: [skyBoxMaterial]
            )
        )
        skyBoxEntity.scale = .init(x:-1,y:1,z:1)
        return skyBoxEntity
    }
    private func createObject (model: Entity, moveable: Bool) async -> Entity? {
        
        guard let environment = try? await EnvironmentResource(named: "studio") else { return model }
        
        model.generateCollisionShapes(recursive: true)
        model.components.set(InputTargetComponent())
        
        model.components.set(ImageBasedLightComponent(source: .single(environment)))
        model.components.set(ImageBasedLightReceiverComponent(imageBasedLight: model))
        model.components.set(GroundingShadowComponent(castsShadow: true))
        
        if (moveable) {
            givePhysics(model: model)
        }
        
        model.components[PhysicsMotionComponent.self] = .init()
        
        return model
    }
    private func givePhysics (model: Entity) {
        model.components[PhysicsBodyComponent.self] = .init(PhysicsBodyComponent(
            massProperties: .default,
            material: .generate(staticFriction: 0.8, dynamicFriction: 0.5, restitution: 0.1 ),
            mode: .dynamic))
    }
    var dragGesture: some Gesture {
        
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic //no gravity
                
                //PRINTS COORDINATES
                    //print(value.convert(value.location3D, from: .local, to: .scene))
                //PRINTS VELOCITY
                    //print(value.velocity)
                //print(value.entity.name)
                spaceData.grabbedAny = true
                if (value.entity.name == "Sphere_Material_002_0") {             //earth
                    resetShow()
                    spaceData.showEarthInfo = true
                    spaceData.lastPickEarth = true
                    spaceData.currentlyEarth = true
                } else if (value.entity.name == "mars_base_realistic_lod0") {   //mars
                    resetShow()
                    spaceData.showMarsInfo = true
                    spaceData.lastPickMars = true
                    spaceData.currentlyMars = true
                } else if (value.entity.name == "moon_realistic_lod0") {        //moon
                    resetShow()
                    spaceData.showMoonInfo = true
                    spaceData.lastPickMoon = true
                    spaceData.currentlyMoon = true
                } else if (value.entity.name == "mercury_base_realistic_lod0") { //mercury
                    resetShow()
                    spaceData.showMercuryInfo = true
                    spaceData.lastPickMercury = true
                    spaceData.currentlyMercury = true
                } else if (value.entity.name == "venus_base_realistic_lod0") { //venus
                    resetShow()
                    spaceData.showVenusInfo = true
                    spaceData.lastPickVenus = true
                    spaceData.currentlyVenus = true
                } else if (value.entity.name == "neptune_base_realistic_lod0") { //neptune
                    resetShow()
                    spaceData.showNeptuneInfo = true
                    spaceData.lastPickNeptune = true
                    spaceData.currentlyNeptune = true
                } else if (value.entity.name == "uranus_base_realistic_lod0") { //uranus
                    resetShow()
                    spaceData.showUranusInfo = true
                    spaceData.lastPickUranus = true
                    spaceData.currentlyUranus = true
                } else if (value.entity.name == "saturn_body_realistic_lod0") { //saturn
                    resetShow()
                    spaceData.showSaturnInfo = true
                    spaceData.lastPickSaturn = true
                    spaceData.currentlySaturn = true
                } else if (value.entity.name == "jupiter_base_realistic_lod0") { //jupiter
                    resetShow()
                    spaceData.showJupiterInfo = true
                    spaceData.lastPickJupiter = true
                    spaceData.currentlyJupiter = true
                } 
                //ROCKETS BELOW
                else if (value.entity.name == "defaultMaterial_004_001") { //discovery shuttle
                    resetShow()
                    spaceData.showDiscoveryInfo = true
                    spaceData.lastPickDiscovery = true
                    spaceData.currentlyDiscovery = true
                } else if (value.entity.name == "Object_2") { //falcon 9
                    resetShow()
                    spaceData.showFalconInfo = true
                    spaceData.lastPickFalcon = true
                    spaceData.currentlyFalcon = true
                } else if (value.entity.name == "White_Panel_material_004") { //ISS
                    resetShow()
                    spaceData.showISSInfo = true
                    spaceData.lastPickISS = true
                    spaceData.currentlyISS = true
                } else if (value.entity.name == "Object_0_001") { //sputnik
                    resetShow()
                    spaceData.showSputnikInfo = true
                    spaceData.lastPickSputnik = true
                    spaceData.currentlySputnik = true
                } else if (value.entity.name == "polySurface1238_phong36_0") { //saturn v
                    resetShow()
                    spaceData.showSaturnVInfo = true
                    spaceData.lastPickSaturnV = true
                    spaceData.currentlySaturnV = true
                } 
                //FICTION BELOW
                else if (value.entity.name == "Object_33") { //borg cube
                    resetShow()
                    spaceData.showBorgInfo = true
                    spaceData.lastPickBorg = true
                    spaceData.currentlyBorg = true
                } else if (value.entity.name == "Death_Star_02___Default_0") { //death star
                    resetShow()
                    spaceData.showDeathInfo = true
                    spaceData.lastPickDeath = true
                    spaceData.currentlyDeath = true
                } else if (value.entity.name == "Object_0_005") { //enterprise
                    resetShow()
                    spaceData.showEnterpriseInfo = true
                    spaceData.lastPickEnterprise = true
                    spaceData.currentlyEnterprise = true
                } else if (value.entity.name == "Object_11") { //tie fighter
                    resetShow()
                    spaceData.showTieInfo = true
                    spaceData.lastPickTie = true
                    spaceData.currentlyTie = true
                } else if (value.entity.name == "Object_1") { //millennium falcon
                    resetShow()
                    spaceData.showMillenniumInfo = true
                    spaceData.lastPickMillennium = true
                    spaceData.currentlyMillennium = true
                } else if (value.entity.name == "Halo_Ring_03___Default_0") { //halo array
                    resetShow()
                    spaceData.showHaloInfo = true
                    spaceData.lastPickHalo = true
                    spaceData.currentlyHalo = true
                } else if (value.entity.name == "Object_44") { //tardis
                    resetShow()
                    spaceData.showTardisInfo = true
                    spaceData.lastPickTardis = true
                    spaceData.currentlyTardis = true
                } else if (value.entity.name == "Object_0_002") { //star destroyer
                    resetShow()
                    spaceData.showDestroyerInfo = true
                    spaceData.lastPickDestroyer = true
                    spaceData.currentlyDestroyer = true
                }

            }
            .onEnded { value in
                value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
                resetCurrent()
            }
    }
    
    func resetShow () {
        spaceData.showMercuryInfo = false
        spaceData.showVenusInfo = false
        spaceData.showEarthInfo = false
        spaceData.showMoonInfo = false
        spaceData.showMarsInfo = false
        spaceData.showJupiterInfo = false
        spaceData.showSaturnInfo = false
        spaceData.showNeptuneInfo = false
        spaceData.showUranusInfo = false

        spaceData.lastPickMercury = false
        spaceData.lastPickVenus = false
        spaceData.lastPickEarth = false
        spaceData.lastPickMars = false
        spaceData.lastPickMoon = false
        spaceData.lastPickJupiter = false
        spaceData.lastPickSaturn = false
        spaceData.lastPickNeptune = false
        spaceData.lastPickUranus = false
        
        spaceData.showDiscoveryInfo = false
        spaceData.showFalconInfo = false
        spaceData.showISSInfo = false
        spaceData.showWebbInfo = false
        spaceData.showSaturnVInfo = false
        spaceData.showSputnikInfo = false
        
        spaceData.lastPickDiscovery = false
        spaceData.lastPickFalcon = false
        spaceData.lastPickISS = false
        spaceData.lastPickWebb = false
        spaceData.lastPickSaturnV = false
        spaceData.lastPickSputnik = false
        
        spaceData.showBorgInfo = false
        spaceData.showDeathInfo = false
        spaceData.showEnterpriseInfo = false
        spaceData.showHaloInfo = false
        spaceData.showExpressInfo = false
        spaceData.showMillenniumInfo = false
        spaceData.showTardisInfo = false
        spaceData.showTieInfo = false
        spaceData.showDestroyerInfo = false
        
        spaceData.lastPickBorg = false
        spaceData.lastPickDeath = false
        spaceData.lastPickEnterprise = false
        spaceData.lastPickHalo = false
        spaceData.lastPickExpress = false
        spaceData.lastPickMillennium = false
        spaceData.lastPickTardis = false
        spaceData.lastPickTie = false
        spaceData.lastPickDestroyer = false
        
    }
    func resetCurrent() {
        spaceData.currentlyMercury = false
        spaceData.currentlyVenus = false
        spaceData.currentlyMars = false
        spaceData.currentlyEarth = false
        spaceData.currentlyMoon = false
        spaceData.currentlyJupiter = false
        spaceData.currentlySaturn = false
        spaceData.currentlyNeptune = false
        spaceData.currentlyUranus = false

        spaceData.currentlyDiscovery = false
        spaceData.currentlyFalcon = false
        spaceData.currentlyISS = false
        spaceData.currentlyWebb = false
        spaceData.currentlySaturnV = false
        spaceData.currentlySputnik = false
        
        spaceData.currentlyBorg = false
        spaceData.currentlyDeath = false
        spaceData.currentlyEnterprise = false
        spaceData.currentlyHalo = false
        spaceData.currentlyExpress = false
        spaceData.currentlyMillennium = false
        spaceData.currentlyTardis = false
        spaceData.currentlyTie = false
        spaceData.currentlyDestroyer = false
    }
}

#Preview {
    
    ImmersiveView(spaceData: SpaceData())
        .previewLayout(.sizeThatFits)
}
