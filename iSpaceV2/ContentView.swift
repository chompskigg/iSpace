//
//  ContentView.swift
//  iSpaceV2
//
//  Created by Spencer Luke on 1/29/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @ObservedObject var spaceData: SpaceData
        
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var showPlanetInfoBool = false
    @State private var showQuizInfoBool = false
    @State private var showHomeInfoBool = true

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        
        TabView {
            //Home Page
            NavigationStack {
                VStack() {
                    VStack {
                        Text("Welcome to iSpace!")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .padding(.bottom, 30)
                        HStack {
                            VStack (alignment: .leading) {
                                Text("Explore")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                    .frame(maxWidth: .infinity, alignment: .top)
                                    .padding(.bottom, 10)
                                Text("Learn more about the planets, satellites, and ships that exist in space!")
                            }
                            .padding(20)
                            .frame(width: 250, height: 200, alignment: .center)
                            .glassBackgroundEffect()
                            VStack (alignment: .leading) {
                                Text("Quiz")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                    .frame(maxWidth: .infinity, alignment: .top)
                                    .padding(.bottom, 10)
                                Text("Choose a quiz and pick up the objects corresponding to the questions!")
                            }
                            .padding(20)
                            .frame(width: 250, height: 200, alignment: .center)
                            .glassBackgroundEffect()
                        }
                    }
                    .task { //opens immedietly
                        if (!showImmersiveSpace) {
                            await openImmersiveSpace(id: "ImmersiveSpace")
                            showImmersiveSpace = true
                        }
                        
                    }
                    .padding(10)
                    Spacer()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Image("iSpace_logo")
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("iSpace")
                            .font(.largeTitle)
                            .padding(10)
                    }
                    ToolbarItem {
                        Button("Change Scene") {
                            Task {
                                rotateScenes()
                            }
                        }
                    }
                }
                .padding(10)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            //Explore Page
            NavigationStack{
                MainPlanets(spaceData: spaceData)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Image("iSpace_logo")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text("iSpace")
                                .font(.largeTitle)
                                .padding(10)
                        }
                        ToolbarItem {
                            Button("Change Scene") {
                                Task {
                                    rotateScenes()
                                }
                            }
                        }
                    }
                    .padding(10)
            }
            .tabItem {
                Label("Explore", systemImage: "map.fill")
            }
            //Quiz Page
            NavigationStack {
                QuizView(spaceData: spaceData)
                    .toolbar{
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Image("iSpace_logo")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text("iSpace")
                                .font(.largeTitle)
                                .padding(10)
                        }
                        ToolbarItem {
                            Button("Change Scene") {
                                Task {
                                    rotateScenes()
                                }
                            }
                        }
                    }
                    .padding(10)
            }
            .tabItem {
                Label("Quiz", systemImage: "rectangle.fill.on.rectangle.angled.fill")
            }
        }
    }
    
    func showHomeInfo() {
        showHomeInfoBool = true
        showPlanetInfoBool = false
        showQuizInfoBool = true
        resetShow()
    }
    func showPlanetInfo() {
        showHomeInfoBool = false
        showQuizInfoBool = false
        showPlanetInfoBool = true
    }
    func showQuizInfo() {
        showHomeInfoBool = false
        showPlanetInfoBool = false
        showQuizInfoBool = true
        resetShow()
    }
    func resetShow () {
        spaceData.lastPickEarth = false
        spaceData.lastPickMars = false
        spaceData.lastPickMoon = false
    }
    func rotateScenes () {
        spaceData.changescene = true
        spaceData.sceneNum += 1
        if (spaceData.sceneNum > 3) {
            spaceData.sceneNum = 0
        }
    }
}

struct MainPlanets: View {
    @ObservedObject var spaceData: SpaceData
    
    @State private var title = "Explore"
    
    @State private var planets = true
    @State private var rockets = false
    @State private var fiction = false
    
    @State private var isEarth = false
    @State private var isMoon = false
    @State private var isMars = false
    @State private var isVenus = false
    @State private var isMercury = false
    @State private var isNeptune = false
    @State private var isUranus = false
    @State private var isJupiter = false
    @State private var isSaturn = false
    
    @State private var isDiscovery = false
    @State private var isFalcon9 = false
    @State private var isISS = false
    @State private var isJamesWebb = false
    @State private var isSaturnV = false
    @State private var isSputnik = false
    
    @State private var isBorg = false
    @State private var isDeath = false
    @State private var isEnterprise = false
    @State private var isHalo = false
    @State private var isExpress = false
    @State private var isMillennium = false
    @State private var isTardis = false
    @State private var isTie = false
    @State private var isDestroyer = false
    
    var body: some View {
        VStack {
            HStack {
                Text("hold")
                    .hidden()
                    .frame(maxWidth: .infinity, alignment: .leading)
                if (isMercury) {
                    Text("Mercury")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isVenus) {
                    Text("Venus")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if (isEarth) {
                    Text("Earth")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if (isMoon) {
                    Text("Earth's Moon")
                        .font(.system(size: 40, weight: .bold, design: .default))
                    .frame(width: 600, alignment: .center)
                }
                else if (isMars) {
                    Text("Mars")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if (isJupiter) {
                    Text("Jupiter")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if (isSaturn) {
                    Text("Saturn")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if (isNeptune) {
                    Text("Neptune")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if (isUranus) {
                    Text("Uranus")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                } 
                else if (isDiscovery) {
                    Text("Discovery Space Shuttle")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isFalcon9) {
                    Text("Falcon 9 Rocket")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isISS) {
                    Text("International Space Station")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isJamesWebb) {
                    Text("James Webb Space Telescope")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isSaturnV) {
                    Text("Saturn V Rocket")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isSputnik) {
                    Text("Sputnik Satellite")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isBorg) {
                    Text("Borg Cube")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isDeath) {
                    Text("Death Star")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isEnterprise) {
                    Text("USS Enterprise")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isHalo) {
                    Text("Halo Array")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isExpress) {
                    Text("Planet Express")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isMillennium) {
                    Text("Millennium Falcon")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isTardis) {
                    Text("TARDIS")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isTie) {
                    Text("TIE Fighter")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else if (isDestroyer) {
                    Text("Star Destroyer")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(width: 600, alignment: .center)
                }
                else {
                    Text("Explore")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Button("Back") {
                    Task { hideExplore() }
                }
                .if(!isEarth && !isMercury && !isVenus && !isMoon && !isMars && !isJupiter && !isSaturn && !isNeptune && !isUranus && !isDiscovery && !isFalcon9 && !isISS && !isJamesWebb && !isSaturnV && !isSputnik && !isBorg && !isDeath && !isEnterprise && !isHalo && !isExpress && !isMillennium && !isTardis && !isTie && !isDestroyer) { $0.hidden() }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 15)
            }
            .frame(maxWidth: .infinity)
            if (!isEarth && !isMercury && !isVenus && !isMoon && !isMars && !isJupiter && !isSaturn && !isNeptune && !isUranus && !isDiscovery && !isFalcon9 && !isISS && !isJamesWebb && !isSaturnV && !isSputnik && !isBorg && !isDeath && !isEnterprise && !isHalo && !isExpress && !isMillennium && !isTardis && !isTie && !isDestroyer) {
                HStack {
                    Button("Planets") {
                        Task { showPlanets() }
                    }
                    Button("Rockets & Satellites") {
                        Task { showRockets() }
                    }
                    Button("Fiction") {
                        Task { showFiction() }
                    }
                }
                .padding(.bottom, 25)
            }
            if (planets) {
                //diameter, mass, density, grav, day lenght, orbit, temp, pressure, # of moons
                if (isMercury) {
                    ExploreItem(
                        name: "Mercury",
                        text: "Mercury, the smallest planet in the Solar System, has extreme temperature, lacks an atmosphere, and has a cratered surface due to past volcanic activity.",
                        data: [4879, 0.330, 5427, 3.7, 1407.6, 87.9, 167, 0, 0],
                        modelName: "Mercury",
                        modelScale: 0.6,
                        imageName: "mercury"
                    )
                } else if (isVenus) {
                    ExploreItem(
                        name: "Venus",
                        text: "Venus has a toxic atmosphere composed of CO2, enveloping a scorching surface of 900 degrees Fahrenheit, and its thick clouds of sulfuric acid make it inhospitable.",
                        data: [12,104, 4.87, 5243, 8.9, -5832.5, 224.7, 464, 92, 0],
                        modelName: "Venus",
                        modelScale: 0.6,
                        imageName: "venus"
                    )
                } else if (isEarth) {
                    ExploreItem(
                        name: "Earth",
                        text: "Earth, the third planet from the Sun, is characterized by its rich biodiversity, vast oceans, and diverse landscapes. It is the only known celestial body to harbor life.",
                        data: [12,756, 5.97, 5514, 9.8, 23.9, 365.2, 15, 1, 1],
                        modelName: "earthScene",
                        modelScale: 0.5,
                        imageName: "earth"
                    )
                } else if (isMoon) {
                    ExploreItem(
                        name: "Moon (Luna)",
                        text: "The Moon, Earth's natural satellite, influences tides, lackes a significant atmosphere, and serves as a subject of scientific exploration and cultural symbolism.",
                        data: [3,474.8, 0.073, 3340, 1.62, 708.7, 27.3, -20, 0, 0],
                        modelName: "Moon",
                        modelScale: 0.5,
                        imageName: "moon"
                    )
                } else if (isMars) {
                    ExploreItem(
                        name: "Mars",
                        text: "Mars, the red planet, has a reddish appearance due to iron oxide on its surface and it is home to the tallest volcano and the largest canyon in the solar system.",
                        data: [6792, 0.642, 3933, 3.7, 24.7, 687, -65, 0.01, 2],
                        modelName: "Mars",
                        modelScale: 0.6,
                        imageName: "mars"
                    )
                } else if (isJupiter) {
                    ExploreItem(
                        name: "Jupiter",
                        text: "Jupiter, the largest planet, is characterized by its distinctive striped cloud bands and iconic Great Red Spot, a giant storm that has been raging for centuries.",
                        data: [142984, 1898, 1326, 23.1, 9.9, 4332, -110, 0.1, 79],
                        modelName: "Jupiter",
                        modelScale: 0.7,
                        imageName: "jupiter"
                    )
                } else if (isSaturn) {
                    ExploreItem(
                        name: "Saturn",
                        text: "Saturn, the sixth planet from the Sun, is renowned for its stunning system of rings, composed mainly of ice particles and dust, making it a marvel in our solar system.",
                        data: [51118, 86.8, 687, 8.7, 10.7, 10759, -140, 1, 82],
                        modelName: "Saturn",
                        modelScale: 0.5,
                        imageName: "saturn"
                    )
                } else if (isUranus) {
                    ExploreItem(
                        name: "Uranus",
                        text: "Uranus, seventh planet from the Sun, is distinguished by its unique sideways rotation, pale blue-green coloration due to methane in its atmosphere, and icy composition.",
                        data: [51118, 86.8, 1271, 8.7, 17.2, 30688, -195, 1000, 27],
                        modelName: "Uranus",
                        modelScale: 0.7,
                        imageName: "uranus"
                    )
                } else if (isNeptune) {
                    ExploreItem(
                        name: "Neptune",
                        text: "Neptune, the eighth and farthest planet from the Sun, is characterized by its deep blue color, turbulent weather patterns, and its system of moons and rings.",
                        data: [49528, 102, 1638, 11, 16.1, 60182, -200, 1000, 14],
                        modelName: "Neptune",
                        modelScale: 0.7,
                        imageName: "neptune"
                    )
                } else {
                    VStack {
                        ScrollView {
                            VStack {
                                HStack {
                                    VStack { //mercury
                                        Model3D(named:"Mercury")
                                            .scaleEffect(0.3)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isMercury) }) {
                                            Text("Mercury")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { //venus
                                        Model3D(named:"Venus")
                                            .scaleEffect(0.3)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isVenus) }) {
                                            Text("Venus")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // earth
                                        Model3D(named:"earthScene")
                                            .scaleEffect(0.25)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isEarth) }) {
                                            Text("Earth")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                                HStack {
                                    VStack { // Moon
                                        Model3D(named:"Moon")
                                            .scaleEffect(0.3)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isMoon) }) {
                                            Text("Moon")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Mars
                                        Model3D(named:"Mars")
                                            .scaleEffect(0.35)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isMars) }) {
                                            Text("Mars")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Jupiter
                                        Model3D(named:"Jupiter")
                                            .scaleEffect(0.45)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isJupiter) }) {
                                            Text("Jupiter")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                                HStack {
                                    VStack { // Saturn
                                        Model3D(named:"Saturn")
                                            .scaleEffect(0.4)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -160)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isSaturn) }) {
                                            Text("Saturn")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Uranus
                                        Model3D(named:"Uranus")
                                            .scaleEffect(0.4)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isUranus) }) {
                                            Text("Uranus")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Neptune
                                        Model3D(named:"Neptune")
                                            .scaleEffect(0.4)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isNeptune) }) {
                                            Text("Neptune")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                            }
                        }
                    }
                }
            }
            else if (rockets) {
                //rotation is fucked
                if (isDiscovery) {
                    ExploreRocket(
                        name: "Discovery Space Shuttle",
                        text: "The Discovery Space Shuttle was a reusable spacecraft that played a crucial role in deploying satellites, conducting scientific research, and assembling the ISS.",
                        data: [56.1 , 8.7, 78000, 1984],
                        modelName: "discoveryScene",
                        modelScale: 0.09,
                        rotateAxis: [0,0,0],
                        zOffset: -710,
                        yOffset: 20,
                        rotatable: false
                    )
                } else if (isFalcon9) {
                    ExploreRocket(
                        name: "Falcon 9 Rocket",
                        text: "The Falcon 9 rocket, developed by SpaceX, is a reusable launch vehicle renowned for its capability to deliver payloads to orbit, including satellites.",
                        data: [70, 3.7, 549054, 2010],
                        modelName: "Falcon_9_Rocket",
                        modelScale: 0.065,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isISS) {
                    ExploreRocket(
                        name: "International Space Station",
                        text: "The ISS is a collaborative space station orbiting Earth, serving as a laboratory and an international hub for scientific research and technological advancements.",
                        data: [109, 72.8, 420000, 1998],
                        modelName: "ISSScene2",
                        modelScale: 1,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isJamesWebb) {
                    ExploreRocket(
                        name: "James Webb Space Telescope",
                        text: "The JWST is a space observatory designed to peer deeper into the universe than ever before, unveiling the mysteries of cosmic origins and the formation of space objects.",
                        data: [21.2, 6.5, 6500, 2021],
                        modelName: "WebbScene",
                        modelScale: 0.5,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isSaturnV) {
                    ExploreRocket(
                        name: "Saturn V Rocket",
                        text: "The Saturn V was a multi-stage rocket that propelled humanity to the moon during the Apollo missions, showcasing unparalleled engineering and enabling lunar landings.",
                        data: [111, 10.1, 2970000, 1967],
                        modelName: "SaturnV",
                        modelScale: 0.065,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isSputnik) {
                    ExploreRocket(
                        name: "Sputnik Satellite",
                        text: "Created by the USSR, Sputnik 1 was the world's first artificial satellite, marking a significant milestone in human space exploration and igniting the Space Age.",
                        data: [0.58, 0.58, 83.6, 1957],
                        modelName: "sputnikScene",
                        modelScale: 0.7,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else {
                    VStack {
                        ScrollView {
                            VStack {
                                HStack {
                                    VStack { //mercury
                                        Model3D(named:"discoveryScene")
                                            .scaleEffect(0.03)
                                            .rotationEffect(.degrees(90))
                                            .offset(z: -710)
                                            .offset(y: 0)
                                        Button(action: { showExplore(itemName: &isDiscovery) }) {
                                            Text("Discovery Shuttle")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                        .offset(y:-2037)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { //venus
                                        Model3D(named:"Falcon_9_Rocket")
                                            .scaleEffect(0.035)
                                            .rotationEffect(.degrees(45))
                                            .offset(z: -100)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isFalcon9) }) {
                                            Text("Falcon 9")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // earth
                                        Model3D(named:"ISSScene2")
                                            .scaleEffect(0.5)
                                            .rotationEffect(.degrees(0))
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isISS) }) {
                                            Text("ISS")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                                HStack {
                                    VStack { // Moon
                                        Model3D(named:"WebbScene")
                                            .scaleEffect(0.2)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -100)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isJamesWebb) }) {
                                            Text("James Webb Telescope")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Mars
                                        Model3D(named:"SaturnV")
                                            .scaleEffect(0.04)
                                            .rotationEffect(.degrees(45))
                                            .offset(z: -160)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isSaturnV) }) {
                                            Text("Saturn V")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Jupiter
                                        Model3D(named:"sputnikScene")
                                            .scaleEffect(0.5)
                                            .rotationEffect(.degrees(-90))
                                            .offset(z: -200)
                                            .offset(x: 0)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isSputnik) }) {
                                            Text("Sputnik")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                            }
                        }
                    }
                }
            }
            else if (fiction) {
                if (isBorg) {
                    ExploreFiction(
                        name: "Borg Cube",
                        text: "The Borg cube, an ominous vessel from the Star Trek universe, represents the terrifying might and technological superiority of the Borg Collective.",
                        franchise: "Star Trek",
                        data: [3036, 90000000000, 1989],
                        modelName: "borgScene",
                        modelScale: 0.8,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isDeath) {
                    ExploreFiction(
                        name: "Death Star",
                        text: "The Death Star, a colossal space station from the Star Wars saga, embodies the power of the Galactic Empire with its planet-destroying superlaser.",
                        franchise: "Star Wars",
                        data: [150000, 224000000000000000000000, 1977],
                        modelName: "deathScene",
                        modelScale: 1,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isEnterprise) {
                    ExploreFiction(
                        name: "Starship Enterprise",
                        text: "The starship Enterprise, from Star Trek, epitomizes humanity's boundless exploration spirit, embarking on voyages of discovery across space.",
                        franchise: "Star Trek",
                        data: [288.6, 3205000000, 1966],
                        modelName: "enterpriseScene",
                        modelScale: 0.5,
                        rotateAxis: [0,15,0],
                        zOffset: -200,
                        yOffset: 0,
                        rotatable: false
                    )
                } else if (isHalo) {
                    ExploreFiction(
                        name: "Halo Array",
                        text: "The Halo Array is a catastrophic weapon of mass destruction and a tool for galactic reseeding, capable of eradicating life and perservice life.",
                        franchise: "Halo",
                        data: [10000000, 860000000000000000000, 2001],
                        modelName: "haloScene",
                        modelScale: 0.65,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isExpress) {
                    ExploreFiction(
                        name: "Planet Express",
                        text: "The Planet Express, a delivery company and ship in the Futurama universe, navigates the cosmos as it embarks on daring intergalactic deliveries.",
                        franchise: "Futurama",
                        data: [40, 0, 1999],
                        modelName: "expressScene2",
                        modelScale: 0.6,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isMillennium) {
                    ExploreFiction(
                        name: "Millennium Falcon",
                        text: "The Millennium Falcon, piloted by the iconic duo of Han Solo and Chewbacca, renowned for its unparalleled speed and daring escapes.",
                        franchise: "Star Wars",
                        data: [34.75, 200000, 1977],
                        modelName: "falconScene",
                        modelScale: 0.15,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isTardis) {
                    ExploreFiction(
                        name: "TARDIS",
                        text: "The TARDIS, a time-traveling spacecraft, sppearing as an unassuming blue police box on the outside while housing infinite dimensions within.",
                        franchise: "Doctor Who",
                        data: [3.048, 180, 1963],
                        modelName: "tardis",
                        modelScale: 0.08,
                        rotateAxis: [0,15,0],
                        zOffset: -900,
                        yOffset: 0,
                        rotatable: false
                    )
                } else if (isTie) {
                    ExploreFiction(
                        name: "TIE Fighter",
                        text: "The TIE Fighter, epitomizes the formidable military power of the Galactic Empire, characterized by its twin ion engines and agile maneuverability.",
                        franchise: "Star Wars",
                        data: [7.2, 10000, 1977],
                        modelName: "tieScene",
                        modelScale: 0.6,
                        rotateAxis: [0,15,0],
                        zOffset: 0,
                        yOffset: 0,
                        rotatable: true
                    )
                } else if (isDestroyer) {
                    ExploreFiction(
                        name: "Star Destroyer",
                        text: "The Star Destroyer, a colossal warship in the Star Wars saga, embodies the might of the Galactic Empire, featuring a vast armament.",
                        franchise: "Star Wars",
                        data: [1600, 40000000, 1977],
                        modelName: "destroyerScene",
                        modelScale: 0.7,
                        rotateAxis: [0,15,0],
                        zOffset: -50,
                        yOffset: 0,
                        rotatable: true
                    )
                } else {
                    VStack {
                        ScrollView {
                            VStack {
                                HStack {
                                    VStack { //mercury
                                        Model3D(named:"borgScene")
                                            .scaleEffect(0.3)
                                            .rotationEffect(.degrees(90))
                                            .offset(z: -50)
                                            .offset(y: 0)
                                        Button(action: { showExplore(itemName: &isBorg) }) {
                                            Text("Borg Cube")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                        .offset(y:-140)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { //venus
                                        Model3D(named:"deathScene")
                                            .scaleEffect(0.3)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: 0)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isDeath) }) {
                                            Text("Death Star")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // earth
                                        Model3D(named:"enterpriseScene")
                                            .scaleEffect(0.25)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -400)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isEnterprise) }) {
                                            Text("USS Enterprise")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                                HStack {
                                    VStack { // Moon
                                        Model3D(named:"haloScene")
                                            .scaleEffect(0.2)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -50)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isHalo) }) {
                                            Text("Halo Array")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Mars
                                        Model3D(named:"expressScene2")
                                            .scaleEffect(0.3)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isExpress) }) {
                                            Text("Planet Express")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // Jupiter
                                        Model3D(named:"falconScene")
                                            .scaleEffect(0.08)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -130)
                                            .offset(x: 0)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isMillennium) }) {
                                            Text("Millennium Falcon")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                                HStack {
                                    VStack { // millennium faclon
                                        Model3D(named:"tardis")
                                            .scaleEffect(0.03)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -1000)
                                            .offset(x: 0)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isTardis) }) {
                                            Text("Tardis")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // tie fighter
                                        Model3D(named:"tieScene")
                                            .scaleEffect(0.25)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -50)
                                            .offset(x: 0)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isTie) }) {
                                            Text("TIE Fighter")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                    VStack { // destroyer
                                        Model3D(named:"destroyerScene")
                                            .scaleEffect(0.3)
                                            .rotationEffect(.degrees(0))
                                            .offset(z: -100)
                                            .offset(x: 0)
                                            .frame(height:130)
                                        Button(action: { showExplore(itemName: &isDestroyer) }) {
                                            Text("Star Destroyer")
                                                .frame(minWidth: 100, minHeight: 40)
                                                .font(.system(size: 15, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding(10)
                                    }
                                    .frame(maxWidth:220, maxHeight: 220)
                                    .glassBackgroundEffect()
                                }
                            }
                        }
                    }
                }
            }
        }
                    
    }
    
    func showPlanets() {
        planets = true
        rockets = false
        fiction = false
    }
    func showRockets() {
        planets = false
        rockets = true
        fiction = false
    }
    func showFiction() {
        planets = false
        rockets = false
        fiction = true
    }
    
    func showExplore (itemName: inout Bool) {
        hideExplore()
        itemName = true
    }
    func hideExplore () {
        title = "Explore"
        isMercury = false
        isVenus = false
        isEarth = false
        isMoon = false
        isMars = false
        isSaturn = false
        isJupiter = false
        isUranus = false
        isNeptune = false
        isDiscovery = false
        isFalcon9 = false
        isISS = false
        isJamesWebb = false
        isSaturnV = false
        isSputnik = false
        isBorg = false
        isDeath = false
        isEnterprise = false
        isHalo = false
        isExpress = false
        isMillennium = false
        isTardis = false
        isTie = false
        isDestroyer = false
    }
}

struct QuizView: View {
    
    @ObservedObject var spaceData: SpaceData
    
    @AppStorage("easyGrade") public var easyGrade: Int = 0
    @AppStorage("mediumGrade") public var mediumGrade: Int = 0
    @AppStorage("hardGrade") public var hardGrade: Int = 0
    @AppStorage("rocketGrade") public var rocketGrade: Int = 0
    @AppStorage("fictionGrade") public var fictionGrade: Int = 0
    
    @State private var firstQuiz = false
    @State private var secondQuiz = false
    @State private var thirdQuiz = false
    @State private var fourthQuiz = false
    @State private var fifthQuiz = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    var body: some View {
        VStack {
            HStack {
                Text("hold")
                    .hidden()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Quiz")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                Button("Back") {
                    Task { hideQuiz() }
                }
                .if(!firstQuiz && !secondQuiz && !thirdQuiz && !fourthQuiz && !fifthQuiz) { $0.hidden() }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 15)
                //firstQuiz || secondQuiz || thirdQuiz || fourthQuiz || fifthQuiz || sixthQuiz
            }
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            
            if (firstQuiz) {
                QuizFormat(spaceData: spaceData, gradeMain: $easyGrade, questions: ["Pick up Mars.", "Pick up Earth.", "Pick up Saturn.", "Pick up Jupiter.", "Pick up the Moon.", "Pick up Neptune."], questionAnswers: [spaceData.lastPickMars,spaceData.lastPickEarth,spaceData.lastPickSaturn,spaceData.lastPickJupiter,spaceData.lastPickMoon,spaceData.lastPickNeptune], quizName: "planetEasy")
            } else if (secondQuiz) {
                QuizFormat(spaceData: spaceData, gradeMain: $mediumGrade, questions: ["Pick up planet nearest to the Sun.", "Pick up the third planet from the Sun.", "Pick up the biggest planet in the Solar System.", "Pick up the planet farthest from the Sun.", "Pick up the planet with a great storm.", "Pick up the smallest planet in the Solar System."], questionAnswers: [spaceData.lastPickMercury,spaceData.lastPickEarth,spaceData.lastPickJupiter,spaceData.lastPickNeptune,spaceData.lastPickJupiter,spaceData.lastPickMercury], quizName: "planetMedium")
            } else if (thirdQuiz) {
                QuizFormat(spaceData: spaceData, gradeMain: $hardGrade, questions: ["Pick up the coldest planet in the Solar System.", "Pick up the brightest planet.", "Pick up the sixth planet from the Sun.", "Pick up the planet with the shortest years.", "Pick up the planet with the most moons.", "Pick up the hotest planet in the Solar System."], questionAnswers: [spaceData.lastPickUranus,spaceData.lastPickVenus,spaceData.lastPickSaturn,spaceData.lastPickMercury,spaceData.lastPickSaturn,spaceData.lastPickVenus], quizName: "planetHard")
            } else if (fourthQuiz) {
                QuizFormat(spaceData: spaceData, gradeMain: $rocketGrade, questions: ["Pick up the rocket launched in 1967.", "Pick up the object that is in a museum.", "Pick up the first object sent to space.", "Pick up the object currently orbiting Earth.", "Pick up the rocket made by SpaceX.", "Pick up the first man-made satellite."], questionAnswers: [spaceData.lastPickSaturnV,spaceData.lastPickDiscovery,spaceData.lastPickSputnik,spaceData.lastPickISS,spaceData.lastPickFalcon,spaceData.lastPickSputnik], quizName: "rocket")
            } else if (fifthQuiz) {
                QuizFormat(spaceData: spaceData, gradeMain: $fictionGrade, questions: ["Pick up the Galactic Empire's most powerful weapon.", "Pick up the ship piloted by a hive mind.", "Pick up the exploratory vessel.", "Pick up the time machine.", "Pick up the ship known for its speed and escapes.", "Pick up the weapon made to eradicate life in the universe."], questionAnswers: [spaceData.lastPickDeath,spaceData.lastPickBorg,spaceData.lastPickEnterprise,spaceData.lastPickTardis,spaceData.lastPickMillennium,spaceData.lastPickHalo], quizName: "fiction")
            } else {
                VStack {
                    ScrollView {
                        VStack {
                            HStack {
                                VStack {
                                    Text("High Score: \(easyGrade)%")
                                        .offset(y:10)
                                    Model3D(named:"Moon")
                                        .scaleEffect(0.3)
                                        .rotationEffect(.degrees(0))
                                        .frame(height:100)
                                    Button(action: { showQuiz(quizName: &firstQuiz)
                                        quizTypeUpdate() }) {
                                        Text("Solar System Quiz \n Easy")
                                            .frame(idealWidth: 150, idealHeight: 40)
                                            .font(.system(size: 15, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(10)
                                }
                                .frame(maxWidth:220, maxHeight: 220)
                                .glassBackgroundEffect()
                                VStack {
                                    Text("High Score: \(mediumGrade)%")
                                        .offset(y:10)
                                    Model3D(named:"earthScene")
                                        .scaleEffect(0.25)
                                        .rotationEffect(.degrees(0))
                                        .frame(height:100)
                                    Button(action: { 
                                        showQuiz(quizName: &secondQuiz)
                                        quizTypeUpdate() }) {
                                        Text("Solar System Quiz \n Medium")
                                            .frame(idealWidth: 150, idealHeight: 40)
                                            .font(.system(size: 15, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(10)
                                }
                                .frame(maxWidth:220, maxHeight: 220)
                                .glassBackgroundEffect()
                                VStack {
                                    Text("High Score: \(hardGrade)%")
                                        .offset(y:10)
                                    Model3D(named:"Saturn")
                                        .scaleEffect(0.4)
                                        .rotationEffect(.degrees(0))
                                        .offset(z: -160)
                                        .frame(height:100)
                                    Button(action: { 
                                        showQuiz(quizName: &thirdQuiz)
                                        quizTypeUpdate() }) {
                                        Text("Solar System Quiz \n Hard")
                                            .frame(minWidth: 150, minHeight: 40)
                                            .font(.system(size: 15, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .frame(maxWidth:220, maxHeight: 220)
                                .glassBackgroundEffect()
                            }
                            HStack {
                                VStack {
                                    Text("High Score: \(rocketGrade)%")
                                        .offset(y:10)
                                    Model3D(named:"SaturnV")
                                        .scaleEffect(0.045)
                                        .rotationEffect(.degrees(45))
                                        .offset(z: -160)
                                        .frame(height:100)
                                    Button(action: {
                                        showQuiz(quizName: &fourthQuiz)
                                        quizTypeUpdate() }) {
                                        Text("Rockets & Satellites Quiz")
                                            .frame(idealWidth: 150, idealHeight: 40)
                                            .font(.system(size: 15, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(10)
                                }
                                .frame(maxWidth:220, maxHeight: 220)
                                .glassBackgroundEffect()
                                VStack {
                                    Text("High Score: \(fictionGrade)%")
                                        .offset(y:10)
                                    Model3D(named:"destroyerScene")
                                        .scaleEffect(0.45)
                                        .rotationEffect(.degrees(0))
                                        .offset(z: -100)
                                        .frame(height:100)
                                    Button(action: {
                                        showQuiz(quizName: &fifthQuiz)
                                        quizTypeUpdate() }) {
                                        Text("Sci-Fi Ships Quiz")
                                            .frame(idealWidth: 150, idealHeight: 40)
                                            .font(.system(size: 15, weight: .bold, design: .default))
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(10)
                                }
                                .frame(maxWidth:220, maxHeight: 220)
                                .glassBackgroundEffect()
                            }
                        }
                    }
                }
            }
        }
    }
    

    
    func showQuiz (quizName: inout Bool) {
        hideQuiz()
        quizName = true
    }
    
    func quizTypeUpdate () {
        if (firstQuiz || secondQuiz || thirdQuiz) {
            //planets
            if (spaceData.quizType != 0) {
                //if last quiz wasnt planets
                resetShowQuiz()
                spaceData.checkPlanet = true
            }
            spaceData.quizType = 0
        } else if (fourthQuiz) {
            //rockets
            if (spaceData.quizType != 1) {
                //if last quiz wasnt rockets
                resetShowQuiz()
                spaceData.checkRocket = true
            }
            spaceData.quizType = 1
        } else if (fifthQuiz) {
            //fiction
            if (spaceData.quizType != 2) {
                //if last quiz wasnt fiction
                resetShowQuiz()
                spaceData.checkFiction = true
            }
            spaceData.quizType = 2
        }
    }
    
    func resetShowQuiz () {
        spaceData.checkPlanet = false
        spaceData.checkRocket = false
        spaceData.checkFiction = false
    }
    
    func hideQuiz () {
        firstQuiz = false
        secondQuiz = false
        thirdQuiz = false
        fourthQuiz = false
        fifthQuiz = false
    }
}

struct QuizFormat: View {
    @ObservedObject var spaceData: SpaceData
    
    @Binding var gradeMain: Int
    @State var questionNum = 1
    @State private var questionGrade = [0,0,0,0,0,0]
    
    var questions: [String] //6
    var questionAnswers: [Bool]
    var quizName: String

    
    var body: some View {
        VStack {
            VStack {
                switch questionNum {
                    case 1 :
                        VStack {
                            Text(questions[0])
                            (questionAnswers[0] ? Text("True").foregroundColor(.green) : Text("False").foregroundColor(.red))
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    case 2 :
                        VStack {
                            Text(questions[1])
                            (questionAnswers[1] ? Text("True").foregroundColor(.green) : Text("False").foregroundColor(.red))
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    case 3:
                        VStack {
                            Text(questions[2])
                            (questionAnswers[2] ? Text("True").foregroundColor(.green) : Text("False").foregroundColor(.red))
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    case 4:
                        VStack {
                            Text(questions[3])
                            (questionAnswers[3] ? Text("True").foregroundColor(.green) : Text("False").foregroundColor(.red))
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    case 5:
                        VStack {
                            Text(questions[4])
                            (questionAnswers[4] ? Text("True").foregroundColor(.green) : Text("False").foregroundColor(.red))
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    case 6:
                        VStack {
                            Text(questions[5])
                            (questionAnswers[5] ? Text("True").foregroundColor(.green) : Text("False").foregroundColor(.red))
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    case 7:
                        VStack {
                            Text("Grade")
                            if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 0) {
                                Text("0%")
                            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 1) {
                                Text("16%")
                            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 2) {
                                Text("33%")
                            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 3) {
                                Text("50%")
                            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 4) {
                                Text("66%")
                            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 5) {
                                Text("83%")
                            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 6) {
                                Text("100%")
                            }
                        }
                        .font(.system(size: 30, weight: .regular, design: .default))
                    default:
                        Text("Error!")
                }
                HStack{
                    if (questionNum < 7) {
                        Button("Next") { nextQuestion(x: 1) }
                    }
                    Button("Reset") { resetQuestion() }
                }
            }
            .frame(width: 600, height: 300)
            .glassBackgroundEffect()
            Spacer()
        }
    }
    func nextQuestion(x: Int) {
        var grade = 0
        
        // check question
        //planet easy
        if (quizName == "planetEasy") {
            if ((questionNum == 1) && (spaceData.lastPickMars)) {
                questionGrade[0] = 1
            } else if ((questionNum == 2) && (spaceData.lastPickEarth)) {
                questionGrade[1] = 1
            } else if ((questionNum == 3) && (spaceData.lastPickSaturn)) {
                questionGrade[2] = 1
            } else if ((questionNum == 4) && (spaceData.lastPickJupiter)) {
                questionGrade[3] = 1
            } else if ((questionNum == 5) && (spaceData.lastPickMoon)) {
                questionGrade[4] = 1
            } else if ((questionNum == 6) && (spaceData.lastPickNeptune)) {
                questionGrade[5] = 1
            }
        }
        //planet medium
        if (quizName == "planetMedium") {
            if ((questionNum == 1) && (spaceData.lastPickMercury)) {
                questionGrade[0] = 1
            } else if ((questionNum == 2) && (spaceData.lastPickEarth)) {
                questionGrade[1] = 1
            } else if ((questionNum == 3) && (spaceData.lastPickJupiter)) {
                questionGrade[2] = 1
            } else if ((questionNum == 4) && (spaceData.lastPickNeptune)) {
                questionGrade[3] = 1
            } else if ((questionNum == 5) && (spaceData.lastPickJupiter)) {
                questionGrade[4] = 1
            } else if ((questionNum == 6) && (spaceData.lastPickMercury)) {
                questionGrade[5] = 1
            }
        }
        //planet hard
        if (quizName == "planetHard") {
            if ((questionNum == 1) && (spaceData.lastPickUranus)) {
                questionGrade[0] = 1
            } else if ((questionNum == 2) && (spaceData.lastPickVenus)) {
                questionGrade[1] = 1
            } else if ((questionNum == 3) && (spaceData.lastPickSaturn)) {
                questionGrade[2] = 1
            } else if ((questionNum == 4) && (spaceData.lastPickMercury)) {
                questionGrade[3] = 1
            } else if ((questionNum == 5) && (spaceData.lastPickSaturn)) {
                questionGrade[4] = 1
            } else if ((questionNum == 6) && (spaceData.lastPickVenus)) {
                questionGrade[5] = 1
            }
        }
        //rocket
        if (quizName == "rocket") {
            if ((questionNum == 1) && (spaceData.lastPickSaturnV)) {
                questionGrade[0] = 1
            } else if ((questionNum == 2) && (spaceData.lastPickDiscovery)) {
                questionGrade[1] = 1
            } else if ((questionNum == 3) && (spaceData.lastPickSputnik)) {
                questionGrade[2] = 1
            } else if ((questionNum == 4) && (spaceData.lastPickISS)) {
                questionGrade[3] = 1
            } else if ((questionNum == 5) && (spaceData.lastPickFalcon)) {
                questionGrade[4] = 1
            } else if ((questionNum == 6) && (spaceData.lastPickSputnik)) {
                questionGrade[5] = 1
            }
        }
        //fiction
        if (quizName == "fiction") {
            if ((questionNum == 1) && (spaceData.lastPickDeath)) {
                questionGrade[0] = 1
            } else if ((questionNum == 2) && (spaceData.lastPickBorg)) {
                questionGrade[1] = 1
            } else if ((questionNum == 3) && (spaceData.lastPickEnterprise)) {
                questionGrade[2] = 1
            } else if ((questionNum == 4) && (spaceData.lastPickTardis)) {
                questionGrade[3] = 1
            } else if ((questionNum == 5) && (spaceData.lastPickMillennium)) {
                questionGrade[4] = 1
            } else if ((questionNum == 6) && (spaceData.lastPickHalo)) {
                questionGrade[5] = 1
            }
        }
        
        //go next question
        questionNum += x
        resetShow()
        
        //calculate grade
        if (questionNum == 7) {
            if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 0) {
                grade = 0
                if (grade > gradeMain) {
                    gradeMain = grade
                    print("hello")
                }
            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 1) {
                grade = 16
                if (grade > gradeMain) {
                    gradeMain = grade
                }
            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 2) {
                grade = 33
                if (grade > gradeMain) {
                    gradeMain = grade
                }
            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 3) {
                grade = 50
                if (grade > gradeMain) {
                    gradeMain = grade
                }
            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 4) {
                grade = 66
                if (grade > gradeMain) {
                    gradeMain = grade
                }
            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 5) {
                grade = 83
                if (grade > gradeMain) {
                    gradeMain = grade
                }
            } else if (questionGrade[0]+questionGrade[1]+questionGrade[2]+questionGrade[3]+questionGrade[4]+questionGrade[5] == 6) {
                grade = 100
                if (grade > gradeMain) {
                    gradeMain = grade
                }
            }
        }
        // stop out of bounds
        if (questionNum > 7) {
            questionNum = 7
        } else if (questionNum < 1) {
            questionNum = 1
        }
    }
    
    func resetQuestion() {
        questionNum = 1
        resetShow()
        for i in questionGrade {
            questionGrade[i] = 0
        }
        gradeMain = 0
    }
    
    func resetShow () {
        spaceData.lastPickMars = false
        spaceData.lastPickEarth = false
        spaceData.lastPickMoon = false
    }
}

struct ExploreFiction: View {
    @State private var isRotating = 0.0
    
    var name: String
    var text: String
    var franchise: String
    var data: [Double] //4
    var modelName: String
    var modelScale: Double
    var rotateAxis: [Double]
    var zOffset: Double
    var yOffset: Double
    var rotatable: Bool
    
    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    VStack {
                        Text(text)
                            .padding(15)
                            .frame(width: 400, height: 120)
                            .glassBackgroundEffect()
                        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 1) {
                            GridRow {
                                Text("Stat")
                                    .font(Font.headline.weight(.heavy))
                                Text(name)
                                    .font(Font.headline.weight(.heavy))
                                Text("Measurement")
                                    .font(Font.headline.weight(.heavy))
                            }
                            .padding(.bottom, 10)
                            GridRow {
                                Text("Franchise")
                                Text(franchise)
                                Text("")
                            }
                            GridRow {
                                Text("Width")
                                Text("\(data[0], specifier: "%.2f")")
                                Text("Meters")
                            }
                            GridRow {
                                Text("Mass")
                                Text("\(data[1], specifier: "%.0f")")
                                Text("Kg")
                            }
                            GridRow {
                                Text("Appearance")
                                Text("\(data[2], specifier: "%.0f")")
                                Text("Year")
                            }
                        }
                        .frame(width: 400, height: 180)
                        .glassBackgroundEffect()
                        Spacer()
                    }
                    .padding(.trailing, 45)
                    VStack(alignment: .center) {
                        if (rotatable) {
                            Slider(value: $isRotating, in: 0...359)
                                .frame(width: 300, height: 20, alignment: .topLeading)
                                .padding(.bottom, -20)
                                .offset(y:-46)
                        }
                        Model3D(named:modelName)
                            .scaleEffect(modelScale)
                            .offset(z: zOffset)
                            .offset(y: yOffset)
                            .rotation3DEffect(.degrees(isRotating * 2), axis: (x:rotateAxis[0], y:rotateAxis[1], z: rotateAxis[2]))
                            .frame(width: 250, height: 250)
                        Spacer()
                    }
                    .frame(width: 300, height: 300)
                }
                .frame(width: 750, height: 400)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ExploreRocket: View {
    @State private var isRotating = 0.0
    
    var name: String
    var text: String
    var data: [Double] //4
    var modelName: String
    var modelScale: Double
    var rotateAxis: [Double]
    var zOffset: Double
    var yOffset: Double
    var rotatable: Bool
    
    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    VStack {
                        Text(text)
                            .padding(15)
                            .frame(width: 400, height: 120)
                            .glassBackgroundEffect()
                        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 1) {
                            GridRow {
                                Text("Stat")
                                    .font(Font.headline.weight(.heavy))
                                Text(name)
                                    .font(Font.headline.weight(.heavy))
                                Text("Measurement")
                                    .font(Font.headline.weight(.heavy))
                            }
                            .padding(.bottom, 10)
                            GridRow {
                                Text("Height")
                                Text("\(data[0], specifier: "%.2f")")
                                Text("Meters")
                            }
                            GridRow {
                                Text("Diameter")
                                Text("\(data[1], specifier: "%.2f")")
                                Text("Meters")
                            }
                            GridRow {
                                Text("Mass")
                                Text("\(data[2], specifier: "%.2f")")
                                Text("Kg")
                            }
                            GridRow {
                                Text("Date Lauched")
                                Text("\(data[3], specifier: "%.0f")")
                                Text("Year")
                            }
                        }
                        .frame(width: 400, height: 180)
                        .glassBackgroundEffect()
                        Spacer()
                    }
                    .padding(.trailing, 45)
                    VStack(alignment: .center) {
                        if (rotatable) {
                            Slider(value: $isRotating, in: 0...359)
                                .frame(width: 300, height: 20, alignment: .topLeading)
                                .padding(.bottom, -20)
                                .offset(y:-46)
                        }
                        Model3D(named:modelName)
                            .scaleEffect(modelScale)
                            .offset(z: zOffset)
                            .offset(y: yOffset)
                            .rotation3DEffect(.degrees(isRotating * 2), axis: (x:rotateAxis[0], y:rotateAxis[1], z: rotateAxis[2]))
                            .frame(width: 250, height: 250)
                        Spacer()
                    }
                    .frame(width: 300, height: 300)
                }
                .frame(width: 750, height: 400)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ExploreItem: View {
    @State private var isRotating = 0.0
    
    var name: String
    var text: String
    var data: [Double]
    var modelName: String
    var modelScale: Double
    var imageName: String
    
    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    VStack {
                        Text(text)
                            .padding(15)
                            .frame(width: 400, height: 120)
                            .glassBackgroundEffect()
                        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 1) {
                            GridRow {
                                Text("Stat")
                                    .font(Font.headline.weight(.heavy))
                                Text(name)
                                    .font(Font.headline.weight(.heavy))
                                Text("Measurement")
                                    .font(Font.headline.weight(.heavy))
                            }
                            .padding(.bottom, 10)
                            GridRow {
                                Text("Diameter")
                                Text("\(data[0], specifier: "%.2f")")
                                Text("Km")
                            }
                            GridRow {
                                Text("Mass")
                                Text("\(data[1], specifier: "%.2f")")
                                Text("10^24 Kg")
                            }
                            GridRow {
                                Text("Density")
                                Text("\(data[2], specifier: "%.2f")")
                                Text("Kg/m^3")
                            }
                            GridRow {
                                Text("Gravity")
                                Text("\(data[3], specifier: "%.2f")")
                                Text("m/s^2")
                            }
                            GridRow {
                                Text("Day Length")
                                Text("\(data[4], specifier: "%.2f")")
                                Text("Hours")
                            }
                            GridRow {
                                Text("Orbit Length")
                                Text("\(data[5], specifier: "%.2f")")
                                Text("Days")
                            }
                            GridRow {
                                Text("Mean Temp (C)")
                                Text("\(data[6], specifier: "%.2f")")
                                Text("Celcius")
                            }
                            GridRow {
                                Text("Surface Pressure")
                                Text("\(data[7], specifier: "%.2f")")
                                Text("Bars")
                            }
                            GridRow {
                                Text("Number of Moons")
                                Text("\(data[8], specifier: "%.2f")")
                                Text("Number")
                            }
                        }
                        .frame(width: 400, height: 250)
                        .glassBackgroundEffect()
                        Spacer()
                    }
                    .padding(.trailing, 45)
                    VStack(alignment: .center) {
                        Slider(value: $isRotating, in: 0...359)
                            .frame(width: 300, height: 20, alignment: .topLeading)
                            .padding(.bottom, -20)
                            .offset(y:-46)
                        Model3D(named:modelName)
                            .scaleEffect(modelScale)
                            //.offset(z:-150)
                            .rotation3DEffect(.degrees(isRotating * 2), axis: (x:0, y:15, z: 0))
                            .frame(width: 250, height: 250)
                        Spacer()
                    }
                    .frame(width: 300, height: 300)
                }
                .frame(width: 750, height: 400)
                .padding(.bottom, 20)
                Image(imageName)
                    .resizable().frame(height: 250.0)
                    .cornerRadius(15)
            }
        }
    }
}


extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView(spaceData: SpaceData())
}
