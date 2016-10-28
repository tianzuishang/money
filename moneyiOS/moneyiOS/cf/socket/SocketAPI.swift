//
//  SocketAPI.swift
//  moneyiOS
//
//  Created by wang jam on 17/10/2016.
//  Copyright © 2016 jam wang. All rights reserved.
//

import UIKit
import SocketIO

typealias socketCall = (_ data: [Any], _ ack: SocketAckEmitter)->Void

typealias ackCall = (_ ackdata: [Any])->Void


let socketNotConnect = -1
let socketConnected = 0

class SocketAPI: NSObject {
    
    static let serverDomain = ConfigAccess.serverDomain()
    
    
    var socket: SocketIOClient?
    
    override init() {
        
        
        
    }
    
    func connectServer(connectCall: socketCall?, disconnectCall: socketCall?, errorCall: socketCall?, reconnectCall: socketCall?, reconnectAttemptCall: socketCall?) {
        
        
        
        socket = SocketIOClient(socketURL: URL(string: SocketAPI.serverDomain)!, config: [.log(true), .forcePolling(true)])
        
        
        socket?.on("connect", callback: { (data, ack) in
            
            print("socket connect")
            
            if(connectCall != nil){
                connectCall!(data, ack)
            }
        })
        
        
        socket?.on("disconnect", callback: { (data, ack) in
            
            print("socket disconnect")
            if(disconnectCall != nil){
                disconnectCall!(data, ack)
            }

            
        })
        
        
        socket?.on("error", callback: { (data, ack) in
            
            print("socket error")
            
            if(errorCall != nil){
                errorCall!(data, ack)
            }
            
        })
        
        socket?.on("reconnect", callback: { (data, ack) in
            
            print("socket reconnect")
            
            if(reconnectCall != nil){
                reconnectCall!(data, ack)
            }
            
        })
        
        socket?.on("reconnectAttempt", callback: { (data, ack) in
            
            print("socket reconnectAttempt")
            
            if(reconnectAttemptCall != nil){
                reconnectAttemptCall!(data, ack)
            }
            
        })
        

        socket?.connect()
    }
    
    
    func bindEventAction(eventAction:(String,socketCall))->Bool {
        
        if(socket == nil){
            return false
        }
        
        socket?.on(eventAction.0, callback: { (data, ack) in
            eventAction.1(data, ack)
        })
        
        return true
    }
    
    func isConnect() -> Int {
        
        if(socket == nil){
            return socketNotConnect
        }
        
        if(socket?.status == SocketIOClientStatus.notConnected) {
            return socketNotConnect
        }
        
        if(socket?.status == SocketIOClientStatus.connected) {
            return socketConnected
        }
        
        return socketNotConnect
    }
    
    
    func sendMsg(data: Any, event: String, ackCallFunc: ackCall? ) -> Int {
        
        if(socket == nil){
            return socketNotConnect
        }
        
        if(socket?.status == SocketIOClientStatus.notConnected) {
            return socketNotConnect
        }
        
        socket?.emitWithAck(event, with: [data])(0, {ackData in
            if(ackCallFunc != nil){
                ackCallFunc?(ackData)
            }
        })
        
        
        return socketConnected
        
    }

}
