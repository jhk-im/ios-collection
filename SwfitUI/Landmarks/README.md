# Landmarks

## 학습내용

### @StateObject

* 앱 수명주기 동안 속성에 대한 모델객체를 한번만 초기화 할 수 있음

### @State

* 변경될 수 있는 값 또는 값의 집합으로 뷰 동작 및 컨텐츠 레이아웃에 영향을 미침
* view와 subview의 특정한 정보를 보유하기 위해 사용하기 때문에 private으로 생성

### list.filter

* 데이터를 추출하고자 할 때 사용
* 기존 리스트에서 값을 걸러 새로운 리스트 생성

### $(Binding)

* 변경 가능한 상태에 대한 참조 역할
* 사용자의 동작에 따라 뷰 상태를 업데이트

### @EnvironmentObject

* 앱의 많은 뷰와 공유해야 하는 데이터의 경우 사용하는 속성 래퍼
* 앱의 어느곳에서나 모델 데이터를 공유
* 데이터 변경시 뷰가 자동으로 업데이트
* 뷰 생성시점에 .environmentObject에 주입

### Environment

* SwiftUI는 해당 속성 래퍼를 사용하여 액세스할 수 있는 값에 대한 environment 저장소를 제공
* editMode
  * 편집 모드 상태의 optional binding 수신
  * 편집 모드 활성화 상태여부를 나타내며 이를 사용하여 모드를 변경 가능
  * 일부 내장 뷰는 자동으로 편집 모드에서 외형과 동작을 변경 (TextView -> TextField)
  * 직접 커스텀 뷰를 수정하여 editMode에 반응하도록 사용자 정의 가능

### CloasedRange<>

* 하한 이상 상한 이하의 간격을 나타내는 타입
* 범위 인스턴스는 ... 연산자를 사용
* 범위 인스턴스는 상한과 하한을 모두 포함
* 빈 범위는 표현할 수 없음

### overlay

* 현재 뷰에 secondary view 를 overlay 하는 modifier
* ZStack과의 차이점
  * ZStack의 자식뷰들은 서로에 대해 독립적임
  * frame을 따로주지 않는 이상 가장 큰 자식뷰 기준으로 ZStack fit 결정
  * overlay되는 뷰는 부모뷰에 종속됨
  * 부모 뷰의 coordinate space에 존재함

### UIViewRepresentable

* 해당 인스턴스를 사용하여 SwfitUI 인터페이스에서 UIView 객체를 생성하고 관리
* 뷰의 생성, 업데이트, 삭제 관리
* 생성 및 업데이트 프로세스는 SwfitUI 뷰의 동작과 유사함
* UIViewRpresentable과 UIViewControllerRepresentable 유형은 기본 UIKit 유형과 동일한 수명주기를 갖음

### UIPageCortrol

* app document 또는 datamodel entity의 각 페에지에 해당하는 점을 표시하는 컨트롤
* UIControl 하위클래스
* delegation 대신 target-action 패턴을 사용하기 때문에 Coordinator 는 binding 을 업데이트하는 @objc 메서드를 구현함
* target-action pattern
  * 이벤트가 발생할 때 다른 객체에 메시지를 보내는데 필요한 정보를 포함
  * target -> 액션이 호출될 객체 (보통 컨트롤러가 해당됨)
  * action -> 특정 이벤트가 발생했을 때 호출할 메서드
  * a라는 액션이 A클래스와 B클래스에 모두 정의되어 있는경우 혹은 그러한 클래스의 인스턴스가 여러개인 경우에 원하는 객체를 target으로 지정하여 객체의 상황에 따라 선택할 수 있음

### UIViewControllerRepresentable

* SwfitUI 인터페이스에서 UIViewController 객체를 생성 및 관리하기 위한 프로토콜
* 생성 및 업데이트 프로세스는 SwiftUI 뷰 동작과 유사하며, 현재 상태 정보로 ViewController를 구성하는데 사용됨
* 시스템이 ViewController 내부에서 발생하는 변경사항을 자동으로 SwiftUI 인터펭스에 전달하지 않기 때문에 Coordinator 인스턴스를 사용하여 target-action, delegate messages 를 전달

### Coordinator Pattern

* ViewController 가 보유하던 책임 중 Navigation 과 관련된 부분을 다른 인스턴스에서 책임지도록 하는 패턴
* 모든 ViewController는 다른 ViewController 인스턴스를 직접적으로 보유하지 않고 Coordinator 인스턴스만 보유하고 해당 인스턴스에 요청함
* makeUIViewController(context: Context) -> UIPageViewController
  *UIPageViewController 를 생성하는 메서드
  * context 매개변수는 SwiftUI 가 제공하는 환경 정보를 가지고 있음
  * dataSource, delegate 에 coordinator 설정
  * SwiftUI 에서 뷰를 표시할 준비가 완료 되면 한번 호출한 뒤 ViewController 의 생명주기를 관리함
* updateUIViewController(_ pageViewController: UIPageViewController, context: Context)
  * 매개변수로 업데이트할 UIPageViewController 를 입력받음
  * setViewControllers(_:direction:animated:) 메서드를 사용하여 context.coordinator.controllers 배열에 ViewController 리스트를 설정
* Coordinator
  * 각 업데이트 마다 SwfitUI 뷰를 호스팅하는 UIHostingController 를 생성함
  * 이후 PageViewController 의 수명 동안 컨트롤러를 한 번만 초기화
  * UI
* makeCoordinator()
  * UIKit ViewController 를 나타내는 SwiftUI 뷰는 적절한 representable 뷰의 context 일부로 Coordinator 타입을 정의할 수 있음
  * SwiftUI 는 makeUIViewControoler 이전에 makeCoordinaotr() 메서드를 호출하여 ViewController 구성할 때 coordinaotr 객체에 액세스 할 수 있도록 함
  * coordinator 를 사용하여 delegate, dataSource, target-action 을 통한 사용자 이벤트 응담과 같은 일반적인 Cocoa 패턴을 구현할 수 있음
* DataSource
  * 데이터를 받아 뷰를 그려주는 역할
* Delegate
  * 사용자가 DataSource 를 통해 보여지는 부분에서 이벤트를 발생시키는 경우 해당 이벤트에 대한 동작을 수행
* pageViewController(_ pageViewController: UIPageViewController,viewControllerAfter viewController: UIViewController) -> UIViewController?
  * ViewController 간의 관계를 설정하여 서로 스와이프하여 전환할 수 있도록 함
* @Binding var currentPage:Int
  * PageView 내에서 현재 페이지를 추적하는 방법이 필요함
  * PageView @State 속성을 선언하고 해당 속성에 대한 binding을 PageViewController에 전달
  * 전달된 binding 을 업데이트하여 보여지는 페이지와 일치시킴
  * updateUIViewController -> setViewControllers에도 해당 바인딩 값을 전달하여 호출을 업데이트함

* pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool)
  * SwiftUI는 페이지 전환 애니메이션 완료 시 해당 메서드를 호출함
  * 현재 ViewController 의 인덱스를 찾아 바인딩을 업데이트함
  * 이를 위해 makeUIViewController() -> pageViewController.delegate 에 coordinator를 할당함
