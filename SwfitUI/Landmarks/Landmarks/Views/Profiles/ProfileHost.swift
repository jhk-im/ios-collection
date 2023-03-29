//
//  ProfileHost.swift
//  Landmarks
//
//  Created by HUN on 2023/03/28.
//

// MARK: -
/*
 @Environment
 - SwiftUI는 해당 속성 래퍼를 사용하여 액세스할 수 있는 값에 대한 environment 저장소를 제공
 
 .editMode
 - 편집 모드 상태의 optional binding 수신
 - 편집 모드 활성화 상태여부를 나타내며 이를 사용하여 모드를 변경 가능
 - 일부 내장 뷰는 자동으로 편집 모드에서 외형과 동작을 변경 (TextView -> TextField)
 - 직접 커스텀 뷰를 수정하여 editMode에 반응하도록 사용자 정의 가능
 
 */

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}
