//
//  progressBar.swift
//  Screen Timer
//
//  Created by Cierra Morris on 9/27/22.
//

import SwiftUI

struct ProgressBar: View {
    let progress: Double
    var body: some View {
        ZStack {
            Circle() // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    lineWidth: 50
                )
                .frame(minWidth: 0, maxWidth: 300)
                .frame(minHeight: 0, maxHeight: 300)
                .rotationEffect(.degrees(-90))
                                // 1
                                .animation(.easeOut, value: progress)

                
        }
    }
}

struct progressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 0.1)
    }
}
