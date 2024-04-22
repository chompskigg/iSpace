//
//  SkyBoxView.swift
//  iSpaceV2
//
//  Created by Spencer Luke on 3/17/24.
//

import Foundation
import SwiftUI
import RealityKit
import RealityKitContent
import simd

struct SkyBoxView: View {
    
    @ObservedObject var spaceData: SpaceData
    
    var body: some View {
        RealityView { content in
            
          //could be other planets or something
              
        }
    }
}


#Preview {
    
    ImmersiveView(spaceData: SpaceData())
        .previewLayout(.sizeThatFits)
}
