
import UIKit

class InputTextField: UITextField {

  weak var nextResponderOverride: UIResponder?

  override var next: UIResponder? {
    if nextResponderOverride != nil {
      return nextResponderOverride
    } else {
      return super.next
    }
  }

  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if nextResponderOverride != nil {
      return false
    } else {
      return super.canPerformAction(action, withSender: sender)
    }
  }
}
