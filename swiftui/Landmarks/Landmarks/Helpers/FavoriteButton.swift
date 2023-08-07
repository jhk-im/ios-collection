//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by HUN on 2023/03/23.
//

// MARK: -
/*
 @Binding
 - 뷰에서 만든 변경사항을 데이터 소스로 전달
 - SwiftUI가 데이터 흐름을 추적하고 업데이트 처리하는 방법 중 하나
 - 데이터의 일부가 사용자 인터페이스에 표시되고 사용자의 동작에 따라 변경사항이 데이터 소스로 다시 전달됨
 */

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
