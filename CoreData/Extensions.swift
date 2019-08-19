//
//  Extensions.swift
//  CoreData
//
//  Created by Jorge Casariego on 6/13/19.
//  Copyright © 2019 Jorge Casariego. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension UIColor {
    
    static let someColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
    
    static let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
    
    static let darkBlue = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
    
    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func buttonDisabled() -> UIColor {
        return UIColor.rgb(red: 144, green: 144, blue: 144)
    }
    
}

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach({addArrangedSubview($0)})
    }
    
}

extension UIViewController
{
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async  {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
