import Combine

@MainActor
public final class EventPublisher {
    public static let shared = EventPublisher()

    private var subjects: [ObjectIdentifier: Any]

    private init() {
        self.subjects = [:]
    }

    public func publish<Event>(_ event: Event) {
        let subject = subjects[ObjectIdentifier(Event.self)] as? PassthroughSubject<Event, Never>
        subject?.send(event)
    }

    public func onReceive<Event>(
        _ eventType: Event.Type,
        action: @escaping @MainActor (Event) -> Void,
    ) -> AnyCancellable {
        subject(for: eventType).sink { event in action(event) }
    }

    private func subject<Event>(for eventType: Event.Type) -> PassthroughSubject<Event, Never> {
        let key = ObjectIdentifier(eventType)
        if let subject = subjects[key] as? PassthroughSubject<Event, Never> {
            return subject
        }
        let subject = PassthroughSubject<Event, Never>()
        subjects[key] = subject
        return subject
    }
}
