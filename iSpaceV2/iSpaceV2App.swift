//
//  iSpaceV2App.swift
//  iSpaceV2
//
//  Created by Spencer Luke on 1/29/24.
//

import SwiftUI

//@Observable 
class SpaceData: ObservableObject {
    //PLANETS
    @Published var grabbedAny = false
    @Published var showMercuryInfo = false
    @Published var showVenusInfo = false
    @Published var showEarthInfo = false
    @Published var showMoonInfo = false
    @Published var showMarsInfo = false
    @Published var showJupiterInfo = false
    @Published var showSaturnInfo = false
    @Published var showNeptuneInfo = false
    @Published var showUranusInfo = false
    //WHAT ARE USERS HOLDING
    @Published var lastPickMercury = false
    @Published var lastPickVenus = false
    @Published var lastPickEarth = false
    @Published var lastPickMoon = false
    @Published var lastPickMars = false
    @Published var lastPickJupiter = false
    @Published var lastPickSaturn = false
    @Published var lastPickNeptune = false
    @Published var lastPickUranus = false
    //WHAT ARE USERS CURRENTLY HOLDING
    @Published var currentlyMercury = false
    @Published var currentlyVenus = false
    @Published var currentlyEarth = false
    @Published var currentlyMoon = false
    @Published var currentlyMars = false
    @Published var currentlyJupiter = false
    @Published var currentlySaturn = false
    @Published var currentlyNeptune = false
    @Published var currentlyUranus = false
    //ROCKETS&SATELLITES
    @Published var showDiscoveryInfo = false
    @Published var showFalconInfo = false
    @Published var showISSInfo = false
    @Published var showWebbInfo = false
    @Published var showSaturnVInfo = false
    @Published var showSputnikInfo = false
    //WHAT ARE USERS HOLDING
    @Published var lastPickDiscovery = false
    @Published var lastPickFalcon = false
    @Published var lastPickISS = false
    @Published var lastPickWebb = false
    @Published var lastPickSaturnV = false
    @Published var lastPickSputnik = false
    //WHAT ARE USERS CURRENTLY HOLDING
    @Published var currentlyDiscovery = false
    @Published var currentlyFalcon = false
    @Published var currentlyISS = false
    @Published var currentlyWebb = false
    @Published var currentlySaturnV = false
    @Published var currentlySputnik = false
    //FICTION
    @Published var showBorgInfo = false
    @Published var showDeathInfo = false
    @Published var showEnterpriseInfo = false
    @Published var showHaloInfo = false
    @Published var showExpressInfo = false
    @Published var showMillenniumInfo = false
    @Published var showTardisInfo = false
    @Published var showTieInfo = false
    @Published var showDestroyerInfo = false
    //WHAT ARE USERS HOLDING
    @Published var lastPickBorg = false
    @Published var lastPickDeath = false
    @Published var lastPickEnterprise = false
    @Published var lastPickHalo = false
    @Published var lastPickExpress = false
    @Published var lastPickMillennium = false
    @Published var lastPickTardis = false
    @Published var lastPickTie = false
    @Published var lastPickDestroyer = false
    //WHAT ARE USERS CURRENTLY HOLDING
    @Published var currentlyBorg = false
    @Published var currentlyDeath = false
    @Published var currentlyEnterprise = false
    @Published var currentlyHalo = false
    @Published var currentlyExpress = false
    @Published var currentlyMillennium = false
    @Published var currentlyTardis = false
    @Published var currentlyTie = false
    @Published var currentlyDestroyer = false

    //SKY BOX
    @Published var sceneNum = 0
    @Published var changescene = false
    
    @Published var checkPlanet = true
    @Published var checkRocket = false
    @Published var checkFiction = false
    
    //QUIZ
    //0 - planets
    //1 - rockets
    //2 - fiction
    
    @Published var quizType = 0
}

@main
struct iSpaceV2App: App {
    
    @StateObject var spaceData = SpaceData()
    @State var immersionMode: ImmersionStyle = .progressive
    
    var body: some Scene {
        WindowGroup {
            ContentView(spaceData: spaceData)
        }
        .defaultSize(width:850, height:650)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(spaceData: spaceData)
        }
        .immersionStyle(selection: $immersionMode, in: .full)
        
        ImmersiveSpace(id: "SkyBox") {
            SkyBoxView(spaceData: spaceData)
        }
        
    }
}
