import Foundation
import WidgetKit
import ActivityKit
import Observation

@Observable
public class LiveActivityManager {

    private var isAuthorized: Bool

    private var active: String?
    private var checkPermissionTask: Task<(), Never>?

    init() {
        let info = ActivityAuthorizationInfo()
        self.isAuthorized = info.areActivitiesEnabled
        checkPermissionTask = Task {
            await checkPermission(info)
        }
    }

    deinit {
        checkPermissionTask?.cancel()
        checkPermissionTask = nil
    }

    @MainActor
    func checkPermission(_ info: ActivityAuthorizationInfo) async {
        let info = ActivityAuthorizationInfo()
        for await activityEnablement in info.activityEnablementUpdates {
            isAuthorized = activityEnablement
        }
    }

    func startActivity(_ name: String, _ totalTime: TimeInterval) {
//        if active != nil {
//            return
//        }

//        let attributes = JuvisWidgetAttributes(name: name)
//        let initialState = JuvisWidgetAttributes.ContentState(remainTime: totalTime, progress: 0.0)
//
//        let activityContent = ActivityContent(state: initialState, staleDate: .now.advanced(by: 15))
//
//        do {
//            let result = try Activity<JuvisWidgetAttributes>.request(
//                attributes: attributes,
//                content: activityContent
//            )
//            self.active = result.id
//            print("Start Live Activity")
//        } catch (let error) {
//            print("Error requesting Live Activity: \(error.localizedDescription)")
//        }
    }

    func updateActivity(remainTimer: TimeInterval, totalTime: TimeInterval) {
//        Task {
//            let progress = CGFloat(remainTimer) / CGFloat(totalTime)
//            let newContentState = JuvisWidgetAttributes.ContentState(remainTime: remainTimer, progress: progress)
//            let activity = Activity<JuvisWidgetAttributes>.activities.first(where: { $0.id == active })
//            await activity?.update(using: newContentState)
//        }
    }

    func endActivity() {
//        Task {
//            for activity in Activity<JuvisWidgetAttributes>.activities {
//                await activity.end(dismissalPolicy: .immediate)
//            }
//            self.active = nil
//        }
    }
}
