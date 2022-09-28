//
//  Button.swift
//  Screen Timer
//
//  Created by Cierra Morris on 9/22/22.
//

import SwiftUI

struct CustomButton: View {
    @ObservedObject var timer: TimerModel
    
    var body: some View {
        Button {
            timer.toggleTimer()
        } label: {
            Text(timer.timerIsRunning ? "Stop Timer" : "Start Timer")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color("darkBlue"))
                .frame(minWidth: 0, maxWidth: 300)
                .frame(minHeight: 0, maxHeight: 300)
                .background(Color(.white))
                .cornerRadius(.infinity)
        }
        
        
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
