import Foundation
import SwiftUI

extension String {
    public func attributeString() -> AttributedString {
        AttributedString(self)
    }

    public func attributeString(_ text: String, _ forgroundColor: Color? = nil, _ font: Font? = nil) -> AttributedString {
        var result = attributeString()
        result = result.foregroundColor(text, forgroundColor)
        result = result.font(text, font)
        return result
    }
    
    public func attributeString(_ text: String, _ font: Font? = nil) -> AttributedString {
        var result = attributeString()
        result = result.font(text, font)
        return result
    }
}

extension AttributedString {
    
    public func attributeString(_ text: String, _ foregroundColor: Color? = nil, _ font: Font? = nil) -> AttributedString {
        var result = self
        result = result.foregroundColor(text, foregroundColor)
        result = result.font(text, font)
        return result
    }
    
    public func foregroundColor(_ text: String, _ foregroundColor: Color? = nil) -> AttributedString {
        guard let range = self.range(of: text) else { return self }
        var result = self
        if let foregroundColor = foregroundColor {
            result[range].foregroundColor = foregroundColor
        }
        return result
    }

    public func font(_ text: String, _ font: Font?  = nil) -> AttributedString {
        guard let range = self.range(of: text) else { return self }
        var result = self
        if let font = font {
            result[range].font = font
        }
        return result
    }
}
