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
  @IBOutlet weak var textField: InputTextField!
  @IBOutlet weak var sendButton: UIButton!
  var manager : SocketManager!
  var messages = [String]()
  @IBAction func action_sendMessage(_ sender: Any) {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    messages.append(contentsOf: ["test1","test2","test3","test4"])
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()
  }
  
  func integrateSocket(){
    
    manager = SocketManager(
      socketURL: URL(string: "https://13aff160.ngrok.io")!,
      config: [
        .log(true)
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

extension ViewController : UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageIdentifer", for: indexPath) as! MessageCell
    cell.bodyLabel.text = messages[indexPath.item]
    cell.bubbleView.associatedTextView = self.textField
    cell.bubbleView.onCopy = {[unowned self] in
      UIPasteboard.general.string = self.messages[indexPath.item]
    }
    return cellq
  }
  
}

extension ViewController : UICollectionViewDelegate {
  
//  func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//    return true
//  }
//
//  func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//    if action.description == "copy:" {
//      print("allow copy")
//      return true
//    }
//    return false
//  }
//
//  func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//  }
  
  
  
}

extension ViewController : UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 100)
  }
  
}
