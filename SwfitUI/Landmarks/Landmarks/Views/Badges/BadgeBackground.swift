//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by HUN on 2023/03/24.
//

// MARK: -
/*
Path
 - 2D 모양의 윤곽선
 - 사용자가 원하는 Custom Shape를 그릴수 있도록 지원
 - move() : drawing cursor를 shape의 경계내에서 이동시킴
 - addLine() : 경로에 지정된 끝점까지 일련의 직선 세그먼트를 추가 / 이전 경로의 끝점에서 새로운 끝점까지 선을 그어 경로 연장
 - addQuadCurve(): 지정된 끝점과 제어점(control point)을 사용하여 이차 베지어 곡선(quadratic Bezier curve)을 경로에 추가
 
 GeometryReader
 - 하드코딩 된 값 대신에 정의된 크기를 사용할 수 있도록 래핑
 - 자체 크기와 좌표 공간에 따라 내용물을 정의하는 컨테이너 뷰
 - 모든 레이아웃에 대해 유연한 flexeible preferred size를 반환
 
 .aspectRatio()
 - .fit : 화면의 가로/세로 중 짧은곳에 맞추어 이미지 크기를 맞춤
 - .fill : 이미지 원본 크기 그대로 표시
*/

import SwiftUI

struct BadgeBackground: View {
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )

                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )

                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
