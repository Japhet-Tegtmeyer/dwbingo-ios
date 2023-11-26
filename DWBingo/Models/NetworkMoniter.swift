//
//  NetworkMoniter.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import Foundation
import Network

// Define a class for monitoring network connectivity
@Observable
class NetworkMonitor {
    
    // Create an instance of NWPathMonitor to monitor network paths
    private let networkMonitor = NWPathMonitor()
    
    // Define a worker queue for handling network updates
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    // Published property to track network connectivity status
    var isConnected = false

    // Initialize the network monitor
    init() {
        // Set the path update handler to update isConnected based on network status
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        
        // Start monitoring network paths on the worker queue
        networkMonitor.start(queue: workerQueue)
    }
}
