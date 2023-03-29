//
//  HikeBadge.swift
//  Landmarks
//
//  Created by HUN on 2023/03/28.
//

// MARK: -
/*
 .accessibilityLabel(_:)
 - 텍스트에 대한 대체 접근성 레이블 제공
 - 유니크하게 식별하여 UI Element에 접근
 - 최종 사용자를 대상으로 하는 값(end-user facing)
 - 로컬라이징 된 string 값을 넣음
 - .accessibilityIdentifier -> 개발자 전용
 */

import SwiftUI

struct HikeBadge: View {
    var name: String
    
    var body: some View {
        VStack(alignment: .center) {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
