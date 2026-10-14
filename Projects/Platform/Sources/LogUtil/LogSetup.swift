import Foundation
import CocoaLumberjack

public class LogSetup {
    public static func setupLogger() {
        #if DEBUG
                let consoleLogger = DDOSLogger.sharedInstance
                consoleLogger.logFormatter = LogFormatter()
                DDLog.add(consoleLogger)            // console logger
        #else
                let fileLogger: DDFileLogger = DDFileLogger()   // File Logger
                fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hour rolling
                fileLogger.maximumFileSize = 1 * 1024 * 1024
                fileLogger.logFileManager.maximumNumberOfLogFiles = 4

//                let crashlyticsLogger = DDCrashlyticsLogger()   // Crashtics Logger
//                crashlyticsLogger.logFormatter = LogFormatter()

                DDLog.add(fileLogger)
//                DDLog.add(crashlyticsLogger)
        #endif
    }
}
