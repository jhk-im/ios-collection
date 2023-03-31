//
//  PageControl.swift
//  Landmarks
//
//  Created by HUN on 2023/03/30.
//

// MARK: -
/*
 UIViewRepresentable
 - 해당 인스턴스를 사용하여 SwfitUI 인터페이스에서 UIView 객체를 생성하고 관리
 - 뷰의 생성, 업데이트, 삭제 관리
 - 생성 및 업데이트 프로세스는 SwfitUI 뷰의 동작과 유사함
 - UIViewRpresentable과 UIViewControllerRepresentable 유형은 기본 UIKit 유형과 동일한 수명주기를 갖음
 
 UIPageCortrol
 - app document 또는 datamodel entity의 각 페에지에 해당하는 점을 표시하는 컨트롤
 - UIControl 하위클래스
 - delegation 대신 target-action 패턴을 사용하기 때문에 Coordinator 는 binding 을 업데이트하는 @objc 메서드를 구현함
 
 target-action pattern
 - 이벤트가 발생할 때 다른 객체에 메시지를 보내는데 필요한 정보를 포함
 - target -> 액션이 호출될 객체 (보통 컨트롤러가 해당됨)
 - action -> 특정 이벤트가 발생했을 때 호출할 메서드
 - a라는 액션이 A클래스와 B클래스에 모두 정의되어 있는경우 혹은 그러한 클래스의 인스턴스가 여러개인 경우에
 원하는 객체를 target으로 지정하여 객체의 상황에 따라 선택할 수 있음
 */

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
