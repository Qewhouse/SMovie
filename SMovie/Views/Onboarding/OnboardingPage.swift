//
//  OnboardingPage.swift
//  SMovie
//
//  Created by Alexander Altman on 10.04.2023.
//

import UIKit

struct OnBoardingView {
    let title: String
    let subtitle: String

    static let about: Self = .init(
        title: "Your favorite movie or TV show is just a tap away",
        subtitle: "Popular movies & TV shows right inside the app"
    )

    static let favourites: Self = .init(
        title: "Best content is always with you",
        subtitle: "Save your favorites and watch it whenever you want"
    )

    static let genres: Self = .init(
        title: "Any genre of your choice",
        subtitle: "Action or love-story? You'll satisfy any preferences and won't argue anymore"

    )

    static let all: [Self] = [.about, .favourites, .genres]
}
