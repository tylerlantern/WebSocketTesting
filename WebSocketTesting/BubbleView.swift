//
//  BubbleView.swift
//  MenuItemTester
//
//  Created by Alexander Persian  on 4/18/19.
//  Copyright © 2019 Alexander Persian . All rights reserved.
//

import UIKit

class BubbleView: UIView {
  
  weak var associatedTextView: InputTextField?
  var onCopy : (() -> ())?
  
  
  let menuItems: [UIMenuItem] = [
    UIMenuItem(title: "Copy", action: #selector(oneMethod)),
    UIMenuItem(title: "Do sometinh else", action: #selector(twoMethod)),
  ]

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(recognizer:)))
    self.addGestureRecognizer(longPressGesture)
  }

  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(oneMethod) || action == #selector(twoMethod) || action == #selector(threeMethod) {
      return true
    } else {
      return false
    }
  }

  override var canBecomeFirstResponder: Bool {
    return true
  }

  @objc private func handleLongPressGesture(recognizer: UIGestureRecognizer) {
    guard
      recognizer.state == .began,
      let recognizerView = recognizer.view,
      let recognizerSuperview = recognizerView.superview
      else { return }

    if associatedTextView?.isFirstResponder == true {
      associatedTextView?.nextResponderOverride = self
    } else {
      self.becomeFirstResponder()
    }
    let menuController = UIMenuController.shared
    menuController.menuItems = menuItems
    menuController.showMenu(from: recognizerSuperview, rect: recognizerView.frame)
    //    menuController.setMenuVisible(true, animated: true)
    //    menuController
    NotificationCenter.default.addObserver(self, selector: #selector(willHideEditMenu), name: UIMenuController.willHideMenuNotification, object: nil)
  }

  @objc private func oneMethod() {
    print("Action One")
    onCopy?()
  }

  @objc private func twoMethod() {
    print("Action Two")
  }

  @objc private func threeMethod() {
    print("Action Three")
  }

  @objc private func willHideEditMenu() {
    associatedTextView?.nextResponderOverride = nil
    UIMenuController.shared.menuItems = nil
    NotificationCenter.default.removeObserver(self, name: UIMenuController.willHideMenuNotification, object: nil)
  }
}
