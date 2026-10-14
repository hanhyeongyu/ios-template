import Foundation
import UserNotifications
import os

// Adapter
public final class LocalNotificationAdapter: AppNotification {

    private let center: UNUserNotificationCenter

    init(center: UNUserNotificationCenter) {
        self.center = center
    }

    // MARK: Register
    public func registerNotifcation(notification: LocalNotification) async throws -> [String] {
        let requests = notification.triggers.map {
            UNNotificationRequest(
                identifier: $0.key.uuidString,
                content: notification.content,
                trigger: $0.value
            )
        }

        for request in requests {
            try await center.add(request)
        }

        os_log("registerNotification: \(requests.map({ $0.identifier }))")
        return requests.map({ $0.identifier })
    }

    // MARK: unRegister
    public func unRegisterNotification(id: String) async {
        let requests = await center.pendingNotificationRequests()
        requests.filter { $0.identifier == id }
            .forEach { request in
                center.removePendingNotificationRequests(withIdentifiers: [request.identifier])
            }
        os_log("unRegisterNotification: \(id)")
    }

    public func unRegisterNotifications(ids: [String]) async {
        ids.forEach {
            center.removePendingNotificationRequests(withIdentifiers: [$0])
        }
        os_log("unRegisterNotifications: \(ids)")
    }

}
