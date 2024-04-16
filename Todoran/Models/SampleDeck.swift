//
//  SampleDeck.swift
//  Todoran
//
//  Created by Doran on 4/13/24.
//

import Foundation

struct SampleDeck {
    static var contents: [Schedule] = [
        Schedule(name: "프로젝트 미팅", creationDate: Date(), isComplete: false),
        Schedule(name: "코드 리뷰", creationDate: Date().addingTimeInterval(-86400), isComplete: true), // 하루 전
        Schedule(name: "디자인 브레인스토밍", creationDate: Date().addingTimeInterval(-172800), isComplete: false) // 이틀 전
    ]
}
