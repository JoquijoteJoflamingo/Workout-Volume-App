@_private(sourceFile: "ContentView.swift") import github_test
import SwiftUI
import SwiftUI

extension ContentView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/josephschaubroeck/Desktop/IOS App Development/github_test/github_test/ContentView.swift", line: 19)
        ContentView()
    #sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/josephschaubroeck/Desktop/IOS App Development/github_test/github_test/ContentView.swift", line: 12)
        Text(__designTimeString("#10089.[1].[0].property.[0].[0].arg[0].value", fallback: "Hello, world!"))
            .padding()
    #sourceLocation()
    }
}

import struct github_test.ContentView
import struct github_test.ContentView_Previews