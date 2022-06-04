//
//  DetailView.swift
//  workout_app
//
//  Created by Joseph Schaubroeck on 5/20/22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            FractionText(numerator: 12, denominator: 18)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
