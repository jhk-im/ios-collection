//
//  PageViewController.swift
//  Landmarks
//
//  Created by HUN on 2023/03/30.
//

// MARK: -
/*
 UIViewControllerRepresentable
 - SwfitUI 인터페이스에서 UIViewController 객체를 생성 및 관리하기 위한 프로토콜
 - 생성 및 업데이트 프로세스는 SwiftUI 뷰 동작과 유사하며, 현재 상태 정보로 ViewController를 구성하는데 사용됨
 - 시스템이 ViewController 내부에서 발생하는 변경사항을 자동으로 SwiftUI 인터펭스에 전달하지 않기 때문에
 Coordinator 인스턴스를 사용하여 target-action, delegate messages 를 전달
 
 Coordinator Pattern
 - ViewController 가 보유하던 책임 중 Navigation 과 관련된 부분을 다른 인스턴스에서 책임지도록 하는 패턴
 - 모든 ViewController는 다른 ViewController 인스턴스를 직접적으로 보유하지 않고 Coordinator 인스턴스만 보유하고 해당 인스턴스에 요청함
 
 makeUIViewController(context: Context) -> UIPageViewController
 - UIPageViewController 를 생성하는 메서드
 - context 매개변수는 SwiftUI 가 제공하는 환경 정보를 가지고 있음
 - dataSource, delegate 에 coordinator 설정
 - SwiftUI 에서 뷰를 표시할 준비가 완료 되면 한번 호출한 뒤 ViewController 의 생명주기를 관리함
 
 updateUIViewController(_ pageViewController: UIPageViewController, context: Context)
 - 매개변수로 업데이트할 UIPageViewController 를 입력받음
 - setViewControllers(_:direction:animated:) 메서드를 사용하여 context.coordinator.controllers 배열에 ViewController 리스트를 설정
 
 Coordinator
 - 각 업데이트 마다 SwfitUI 뷰를 호스팅하는 UIHostingController 를 생성함
 - 이후 PageViewController 의 수명 동안 컨트롤러를 한 번만 초기화
 - UI
 
 makeCoordinator()
 - UIKit ViewController 를 나타내는 SwiftUI 뷰는 적절한 representable 뷰의 context 일부로 Coordinator 타입을 정의할 수 있음
 - SwiftUI 는 makeUIViewControoler 이전에 makeCoordinaotr() 메서드를 호출하여 ViewController 구성할 때 coordinaotr 객체에 액세스 할 수 있도록 함
 - coordinator 를 사용하여 delegate, dataSource, target-action 을 통한 사용자 이벤트 응담과 같은 일반적인 Cocoa 패턴을 구현할 수 있음
 
 DataSource
 - 데이터를 받아 뷰를 그려주는 역할
 
 Delegate
 - 사용자가 DataSource 를 통해 보여지는 부분에서 이벤트를 발생시키는 경우 해당 이벤트에 대한 동작을 수행
 
 pageViewController(_ pageViewController: UIPageViewController,viewControllerBefore viewController: UIViewController) -> UIViewController?
 pageViewController(_ pageViewController: UIPageViewController,viewControllerAfter viewController: UIViewController) -> UIViewController?
 - ViewController 간의 관계를 설정하여 서로 스와이프하여 전환할 수 있도록 함
 
 @Binding var currentPage:Int
 - PageView 내에서 현재 페이지를 추적하는 방법이 필요함
 - PageView @State 속성을 선언하고 해당 속성에 대한 binding을 PageViewController에 전달
 - 전달된 binding 을 업데이트하여 보여지는 페이지와 일치시킴
 - updateUIViewController -> setViewControllers에도 해당 바인딩 값을 전달하여 호출을 업데이트함
 
 pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool)
 - SwiftUI는 페이지 전환 애니메이션 완료 시 해당 메서드를 호출함
 - 현재 ViewController 의 인덱스를 찾아 바인딩을 업데이트함
 - 이를 위해 makeUIViewController() -> pageViewController.delegate 에 coordinator를 할당함
 
 */

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()

        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
