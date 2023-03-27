//
//  Landmark.swift
//  Landmarks
//
//  Created by HUN on 2023/03/17.
//

// MARK: - Create a Landmark Model
/**
Hashable
 - Hasher로 정수 hash 값을 생성할 수 있는 Type
 - 해당 Protocol을 준수하는 모든 Type을 Set 또는 Dictionary의 Key로 사용
 - Standard library types는 Hashable을 준수하며 기본적으로 해싱 가능
 - Optionals, Ranges, Arrays와 같은 경우 Type Arguments가 동일한 hashable을 구현하는 경우 자동으로 해싱 가능
 - Custom Types도 해싱 가능
   - 연관 값이 없는 Enumeration(Enum=열거형)을 정의하면 Hashable 적합성을 자동으로 획득하고 다른 Custom Type에 대하여 hash(into:) 메서드를 구현
   - 모든 Stored properties가 hashable인 structs와 모든 hashable 연관 값을 가진 enum types인 경우 컴파일러가 자동으로 hash(into:) 구현을 제공
 
Codable
 - Structure와 Data File간에 데이터 이동을 간편하게 해줌
 - External Representation(외부 표현) 으로 스스로 변환하고 다시 변환할 수 있는 Type
 - Encodable 및 Decodable Protocol의 typealias
 
TypeAlias
 - 기존에 선언되어 있는 Type에 새로운 Type의 별칭을 사용하여 코드를 더 읽기 쉽도록 만드는 문법
 - 내장(String, Int, Float...) / 사용자 정의(Class, Struct, Enum...) / 복합(Closure)
 ex)
1. 내장
 typealias Name = String
 let name:  Name = "Kim"
 let name: String = "Lee"
 특별한 분류가 필요하거나 구분지어 사용하고 싶을 때
 
2. 사용자 정의
 Class Student { }
 typealias Students = [Student]
 var students: Students = []
 
3. 복합
 func test(completeHandler: (Void) -> (Void)) { }
 typealias voidHandler = (Void) -> (Void)
 func test(completeHandler: voidHandler) { }
 
 CLLocationCoordinate2D
 - WGS 84 기준 프레임을 사용하여 지정된 위치와 관련된 위도(latitude) / 경도(longitude)
 
 CaseIterable
 - 해당 프로토콜을 준수하는 유형은 일반적으로 연관 값이 없는 enumerations
 - type의 allCases 속성을 사용하여 모든 케이스 컬렉션에 액세스할 수 있음
 */


import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
