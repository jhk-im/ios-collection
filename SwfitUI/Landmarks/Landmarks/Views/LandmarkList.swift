//
//  LandmarkList.swift
//  Landmarks
//
//  Created by HUN on 2023/03/20.
//

// MARK: -
/**
 @State
 - 변경될 수 있는 값 또는 값의 집합으로 뷰 동작 및 컨텐츠 레이아웃에 영향을 미침
 - view와 subview의 특정한 정보를 보유하기 위해 사용하기 때문에 private으로 생성

 list.filter
 - 데이터를 추출하고자 할 때 사용
 - 기존 리스트에서 값을 걸러 새로운 리스트 생성
 
 $(Binding)
 - 변경 가능한 상태에 대한 참조 역할
 - 사용자의 동작에 따라 뷰 상태를 업데이트
 
 @EnvironmentObject
 - 앱의 많은 뷰와 공유해야 하는 데이터의 경우 사용하는 속성 래퍼
 - 앱의 어느곳에서나 모델 데이터를 공유
 - 데이터 변경시 뷰가 자동으로 업데이트
 - 뷰 생성시점에 .environmentObject에 주입
 */

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredLandmarks, id: \.id) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
//            LandmarkList()
//                .previewDevice(PreviewDevice(rawValue: deviceName))
//                .previewDisplayName(deviceName)
//        }
        LandmarkList()
            .environmentObject(ModelData())
    }
}
