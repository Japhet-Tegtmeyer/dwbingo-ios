//
//  MotionManager.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/22/23.
//

import Foundation
import CoreMotion

// Define a class for managing motion updates
class MotionManager: ObservableObject {
    
    // Create an instance of CMMotionManager to handle motion data
    private let motionManager = CMMotionManager()

    // Published properties to track pitch and roll angles
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    // Function to start monitoring motion updates
    func startMonitoringMotionUpdates() {
        
        // Check if device motion is available on the current device
        guard self.motionManager.isDeviceMotionAvailable else {
            print("Device motion not available")
            return
        }
        
        // Set the update interval for device motion
        self.motionManager.deviceMotionUpdateInterval = 0.01
        
        // Start receiving device motion updates on the main queue
        self.motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            // Check if motion data is available
            guard let motion = motion else { return }
            
            // Update pitch and roll properties with the latest values
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
        }
    }
    
    // Function to stop monitoring motion updates
    func stopMonitoringMotionUpdates() {
        self.motionManager.stopDeviceMotionUpdates()
    }
}

