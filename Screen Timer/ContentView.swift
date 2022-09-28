//
//  ContentView.swift
//  Screen Timer
//
//  Created by Cierra Morris on 9/22/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timer = TimerModel()
    var body: some View {
        ZStack{
            Color("darkBlue")
                .ignoresSafeArea()
            VStack{
                ZStack {
                    
                    ProgressBar(progress: 1 - timer.timeLeft/timer.totalTime)
                    CustomButton(timer: timer)
                }
                if timer.showAlertMessage{
                    Text("Look at something at least 20 feet away for 20 seconds")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing], 30.0)
                } else {
                    Text("Look at something at least 20 feet away for 20 seconds")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color("darkBlue"))
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing], 30.0)
                }
                
            }.ignoresSafeArea()
            
        }.onAppear(perform: timer.requestPermission)
            .onReceive(NotificationCenter.default.publisher(
                for: UIApplication.willResignActiveNotification
                    )) { _ in
                        timer.movingToBackground()
                    }
            .onReceive(NotificationCenter.default.publisher(
                for: UIApplication.didBecomeActiveNotification
                    )) { _ in
                        timer.movingToForeground()
                    }
        
    }
        
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timer: TimerModel())
    }
}
