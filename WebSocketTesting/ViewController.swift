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
  
  @IBAction func action_sendMessage(_ sender: Any) {
    socket.emit("server", with: [textField.text ?? ""])
  }
  
  let manager = SocketManager(socketURL: URL(string: "ws://echo.websocket.org")!, config: [.log(true), .compress])
  var socket : SocketIO.SocketIOClient  { return manager.defaultSocket }
  override func viewDidLoad() {
    super.viewDidLoad()
  
    socket.on(clientEvent: .connect) {data, ack in
        print("On Connect")
    }

    socket.on(clientEvent: .error) {data, ack in
        print("On Error:",data)
    }
    
    socket.on("user") { (data, ack) in
      print("user:",data)
      ack.with("Got it")
    }
    socket.connect()
    // Do any additional setup after loading the view.
  }

  
  
  

}

