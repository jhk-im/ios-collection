//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by HUN on 2023/03/17.
//

// MARK: -
/**
 @StateObject
 - 앱 수명주기 동안 속성에 대한 모델객체를 한번만 초기화 할 수 있음
 */

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
