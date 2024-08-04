//
//  Activity.swift
//  sport-matcher
//
//  Created by Dawid on 28/07/2024.
//

import Foundation

enum Activity: Int, CaseIterable, Hashable {
    case football
    case basketball
    case tennis
    case voleyball
    case bilard
    case pingPong
    case badminton
    case gym
    case yoga
    case swimming
    case cycling
    case climbing
    case bowling
    case beer
    
    var label: String {
        "\(emoji) \(title)"
    }

    private var emoji: String {
        switch self {
        case .football:
            "⚽️"
        case .basketball:
            "🏀"
        case .tennis:
            "🎾"
        case .voleyball:
            "🏐"
        case .bilard:
            "🎱"
        case .pingPong:
            "🏓"
        case .badminton:
            "🏸"
        case .gym:
            "🏋🏽"
        case .yoga:
            "🧘🏻‍♂️"
        case .swimming:
            "🏊🏿‍♀️"
        case .cycling:
            "🚵🏼‍♀️"
        case .climbing:
            "🧗🏼‍♂️"
        case .bowling:
            "🎳"
        case .beer:
            "🍻"
        }
    }
    
    private var title: String {
        switch self {
        case .football:
            "Football"
        case .basketball:
            "Basketball"
        case .tennis:
            "Tennis"
        case .voleyball:
            "Voleyball"
        case .bilard:
            "Bilard"
        case .pingPong:
            "Ping-pong"
        case .badminton:
            "Badminton"
        case .gym:
            "Gym"
        case .yoga:
            "Yoga"
        case .swimming:
            "Swimming"
        case .cycling:
            "Cycling"
        case .climbing:
            "Climbing"
        case .bowling:
            "Bowling"
        case .beer:
            "Beer"
        }
    }
}
