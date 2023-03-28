//
//  ModalData.swift
//  Landmarks
//
//  Created by HUN on 2023/03/20.
//

// MARK: -
/**
 load()
 - 앱의 메인 번들에서 입력된 파일명의 JSON data를 가져오는 load 메서드
 - Codable 프로토콜의 Decodable 프로토콜을 준수하는 반환 타입에 의존함
 
 Decodable
 - JSON data 혹은 인코딩 된 데이터를 디코딩하는데 사용됨
 
 Obserbvable object
 - SwfitUI 환경에서 Storage에서 View에 Binding 할 수 있는 데이터를 포함하는 사용자 정의 객체
 - 모든 변경사항을 감지하고 변경 후 뷰를 표시
 - Combine 프레임워크의 프로토콜
 
 @Published
 -  데이터 변경사항을 발행
 - Subscriber가 변경사항을 수신
 
 Dictionary -> categories
 - landmarks 배열을 카테고리 별로 그룹화
 - 그룹화된 결과를 카테고리 이름이 key로 설정 된 Dictonary로 변환
 - 카테고리 이름은 category 속성의 rawValue(원시값)로 사용
 */

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    @Published var profile = Profile.default
    
    var hikes: [Hike] = load("hikeData.json")
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
