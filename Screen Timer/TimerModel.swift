//
//  TimerModel.swift
//  Screen Timer
//
//  Created by Cierra Morris on 9/27/22.
//

import Foundation
import UIKit
import AudioToolbox
import AVFoundation
import UserNotifications

class TimerModel: ObservableObject {
//    1200 sec in 20 minutes
    let initialTime = 1200.00
    let showMessageTime = 30.00
    var totalTime : Double
    @Published var timeLeft : Double
    public var timer = Timer()
    public var timerIsRunning = false
    public var showAlertMessage = false
    private var notificationDate: Date = Date()
    
    
    init() {
        totalTime = initialTime
        timeLeft = initialTime
        
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func toggleTimer() {
        if !timerIsRunning {
            startTimer()
        } else {
            stopTimer()
        }
        timerIsRunning.toggle()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer.invalidate()
        timeLeft = initialTime
    }
    
    private func pauseTimer() {
        timer.invalidate()
    }
    
    @objc func timerAction() {
        if timeLeft > 0 {
            timeLeft -= 0.1
            
            //show the alert message for 30 seconds after finishing
            if timeLeft < initialTime - showMessageTime {
                showAlertMessage = false
            }
            //timer finishes running
        } else {
            AudioServicesPlaySystemSound(1016)
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {   }
            showAlertMessage = true
            stopTimer()
            timerIsRunning = false
            toggleTimer()
            
        }
    }
    
    func movingToBackground() {
        print("Moving to the background")
        notificationDate = Date()
        pauseTimer()
    }

    func movingToForeground() {
        print("Moving to the foreground")
        let deltaTime: Int = Int(Date().timeIntervalSince(notificationDate))
        timeLeft -= Double(deltaTime)
        if timerIsRunning{
            startTimer()
        }
        
    }
    
}
