import Foundation
import Network
import CocoaLumberjackSwift
import Observation

@Observable
public class NetworkMonitor {

    public var state: NetworkStatus

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    public init() {
        self.state = NetworkStatus(monitor.currentPath.status)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                DDLogDebug("Network is available")
                printConnectedType(path)
                self.state = NetworkStatus(path.status)
            } else {
                DDLogDebug("No network connection")
            }
        }
        monitor.start(queue: queue)
        
    }
    
    deinit {
        monitor.cancel()
    }
    
    private func printConnectedType(_ path: NWPath) {
        switch true {
         case path.usesInterfaceType(.wifi):
            DDLogDebug("wi-Fi connected")
         case path.usesInterfaceType(.cellular):
            DDLogDebug("celular connected")
         case path.usesInterfaceType(.wiredEthernet):
            DDLogDebug("ethernet connected")
         case path.usesInterfaceType(.loopback):
            DDLogDebug("loopback connected")
         case path.usesInterfaceType(.other):
            DDLogDebug("unkown connected")
         default: break
         }
    }
}

public enum NetworkStatus {
    case satisfied
    case unsatisfied
    case requiresConnection
    
    init(_ status: NWPath.Status) {
        switch status {
        case .satisfied: self = .satisfied
        case .unsatisfied: self = .unsatisfied
        case .requiresConnection: self = .requiresConnection
        @unknown default: fatalError()
        }
    }
}
