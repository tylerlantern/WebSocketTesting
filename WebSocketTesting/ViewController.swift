//
//  ViewController.swift
//  WebSocketTesting
//
//  Created by Nattapong Unaregul on 26/03/2020.
//  Copyright © 2020 Nattapong Unaregul. All rights reserved.
//

import SocketIO
import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var sendButton: UIButton!
  var manager : SocketManager!
  
  @IBAction func action_sendMessage(_ sender: Any) {
//    socket.emit("server", with: [textField.text ?? ""])
  }
//  ws://echo.websocket.org
//  wss://echo.websocket.org
//  let manager = SocketManager(
//    socketURL: URL(string: "ws://echo.websocket.org")!,
//    config: [
//      .log(true),
//      .forceWebsockets(true),
//    ]
//
//  )
//  var socket : SocketIO.SocketIOClient  { return manager.defaultSocket }
  override func viewDidLoad() {
    super.viewDidLoad()
    integrateSocket()
//    manager.defaultSocket.connect()
    // Do any additional setup after loading the view.
  }

  func integrateSocket(){
    
    manager = SocketManager(
      socketURL: URL(string: "wss://echo.websocket.org")!,
      config: [
        .log(true),
        .forceWebsockets(true)
      ]
    
    )
    
     manager.defaultSocket.on(clientEvent: .connect) {data, ack in
        print("On Connect")
    }

     manager.defaultSocket.on(clientEvent: .error) {data, ack in
        print("On Error:",data)
    }
    
     manager.defaultSocket.onAny { (event) in
      print("onAny event:",event.event," items:",event.items)
    }
    
    
    manager.defaultSocket.connect()
  }
  
}

