//
//  ProfileCreationViewModel.swift
//  sport-matcher
//
//  Created by Dawid on 25/07/2024.
//

import Foundation
import SwiftUI

final class ProfileCreationViewModel: ObservableObject {
    private let stringSizeProvider: StringSizeProviderProtocol
    @MainActor @Published var name = ""
    @MainActor @Published var whatsapp = ""
    @MainActor @Published private(set) var activitiesViewWidth = 0.0
    let activityFont = UIFont.systemFont(ofSize: 16)
    let spacerBetweenActivities = 8.0
    let activitiesCellHorizontalPadding = 10.0
    
    init(
        stringSizeProvider: StringSizeProviderProtocol = StringSizeProvider()
    ) {
        self.stringSizeProvider = stringSizeProvider
    }
    
    @MainActor
    func setActivitiesViewWidth(_ width: CGFloat) {
        guard width != activitiesViewWidth else { return }
        DispatchQueue.main.async { [weak self] in
            self?.activitiesViewWidth = width
        }
    }
    
    @MainActor
    func getActivitiesRows() -> [[ActivityRow]] {
        var activitiesRows = [[ActivityRow]]()
        var currentRow = [ActivityRow]()
        var currentRowAvailableWidth = activitiesViewWidth
        Activity.allCases.forEach { activity in
            
            let activityWidth = stringSizeProvider.widthOfString(text: activity.label, usingFont: activityFont) + 2 * activitiesCellHorizontalPadding

            if currentRowAvailableWidth > activityWidth {
                currentRow.append(ActivityRow(activity: activity, width: activityWidth))
                currentRowAvailableWidth -= activityWidth + spacerBetweenActivities
            } else {
                activitiesRows.append(currentRow)
                currentRow = [ActivityRow(activity: activity, width: activityWidth)]
                currentRowAvailableWidth = activitiesViewWidth - (activityWidth + spacerBetweenActivities)
            }
            
            if activity == Activity.allCases.last {
                activitiesRows.append(currentRow)
            }
        }
        return activitiesRows
    }
}
