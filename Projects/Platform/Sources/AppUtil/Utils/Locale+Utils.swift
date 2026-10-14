import Foundation

extension Locale.Language {
    public var isEn: Bool {
        languageCode?.identifier == "en"
    }
    
    public var isKo: Bool {
        languageCode?.identifier == "ko"
    }
    
    // Traditional Chinese
    // Remove zh_HK until console added to the list. Otherwise client sends
    // zh_HK and server/console falls back to zh.
    // @"zh_Hant" : @[ @"zh_HK", @"zh_TW", @"zh-Hant", @"zh-HK", @"zh-TW" ],
    // @"zh_Hant" : @[ @"zh_TW", @"zh-Hant", @"zh-TW" ],
    public var isTaiwan: Bool {
        let isChina = languageCode?.identifier == "zh"
        if !isChina {
            return false
        }
        let isTraditional = script?.identifier == "Hant"
        return isTraditional
    }

    // Simplified Chinese
    public var isChina: Bool {
        let isChinese = languageCode?.identifier == "zh"
        if !isChinese {
            return false
        }
        let isSimplified = script?.identifier == "Hans"
        return isSimplified
    }
}
