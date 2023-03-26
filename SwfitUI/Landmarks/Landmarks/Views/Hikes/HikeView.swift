/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

// MARK: -
/*
 animation(_:)
 - equatable view에서 해당 수식어를 사용하여 SwiftUI에서 애니메이션 가능한 속성에 대한 변경사항을 애니메이션화
 - view가 equatable하지 않은 경우 사용할 수 없음
 
 EquatableView
 - 자신을 이전 값과 비교하여 새 값이 이전 값과 동일한 경우 자식 뷰가 업데이트 되지 않도록 하는 뷰 타입
 
 SwiftUI Animations
 - 미리 정의된 혹은 사용자 정의된 easing과 함께 기본적인 애니메이션 포함 (spring, fluid ...)
 - 애니메이션 속도 조절, 딜레이, 반복 지정
 - .scaleEffect() : 애니메이션 off 설정
 - .rotationEffect() : 회전 설정
 
 상태 값이 변경될 때 애니메이션 적용
 - @State show Detail
 - withAnimation 함수를 사용하여 showDetail 값이 toggle 될 때 애니메이션 적용
 - HikeDetail view에 .transition 수식어를 사용하여 뷰가 이동하는 애니메이션 적용

 extension
 - 클래스, 구조체, 열거형, 프로토콜 타입 등에 새로운 기능을 추가하여 확장할 수 있는 기능
 - 기존에 존재하는 기능을 재정의하는 것은 불가
 - 외부 프레임워크 혹은 라이브러리에 원하는 기능을 추가하고자 할 때 유용
 - 모든 타입에 적용 가능
 - 상송 없이 구조체와 열겨형에도 기능 추가 가능
 
 AnyTransition
 - .transition(_:) 인수에 들어가는 값
 - extension으로 여러가지 애니메이션 속성을 가지고 있음
 - offset(), scale(), opacity, slide 등
 - .asymmetric() : 보여질때와 사라질 때 애니메이션을 다르게 설정
 */

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    withAnimation/*(.easeInOut(duration: 4))*/ {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        //.animation(nil, value: showDetail)
                        //.scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                        //.animation(.spring(), value: showDetail)
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: ModelData().hikes[0])
                .padding()
            Spacer()
        }
    }
}
