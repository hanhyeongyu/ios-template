//
//  PreferenceSamples.swift
//  Notification
//
//  Created by 한현규 on 3/18/25.
//  Copyright © 2025 company. All rights reserved.
//

import Foundation
import SwiftUI

extension PreferenceKeys {
    public var templateTestBool : PrefKey<Bool> { .init(name: "kTemplateTestKey", defaultValue: false) }
}

struct PreferencePreview: View {

    @AppStorage(\PreferenceKeys.templateTestBool)
    private var preferececTestBoolean: Bool

    var body: some View {
        Text("bool: \(preferececTestBoolean)")
    }
}
