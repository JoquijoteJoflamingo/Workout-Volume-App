//
//  FractionText.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/22/22.
//

import Foundation
import SwiftUI

struct FractionText: View {
    var numerator:Int
    var denominator:Int
    var body: some View {
        HStack {
                    Text(String(numerator))
                        .offset(x: 4, y: 0)
                        .alignmentGuide(VerticalAlignment.center,
                                        computeValue: { d in d[.bottom] })
                    Text("∕").font(.system(size: 32))
                    Text(String(denominator))
                        .offset(x: -4, y: 0)
                        .alignmentGuide(VerticalAlignment.center,
                                        computeValue: { d in d[.top] })
                }
    }
}
