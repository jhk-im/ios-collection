//
//  FeatuerCard.swift
//  Landmarks
//
//  Created by HUN on 2023/03/30.
//

// MARK: -
/*
 .overlay
 - 현재 뷰에 secondary view 를 overlay 하는 modifier
 - ZStack과의 차이점
    - ZStack의 자식뷰들은 서로에 대해 독립적임
    - frame을 따로주지 않는 이상 가장 큰 자식뷰 기준으로 ZStack fit 결정
    - overlay되는 뷰는 부모뷰에 종속됨
    - 부모 뷰의 coordinate space에 존재함
 */
import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        landmark.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay {
                TextOverlay(landmark: landmark)
            }
    }
}

struct TextOverlay: View {
    var landmark: Landmark

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}
