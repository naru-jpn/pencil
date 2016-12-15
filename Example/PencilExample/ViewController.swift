//
//  ViewController.swift
//  PencilExample
//
//  Created by naru on 2016/09/21.
//  Copyright © 2016年 naru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Constants {
        static let TitleFont: UIFont = UIFont.systemFont(ofSize: 15.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.titleLabel)
        if let title = self.title {
            self.titleLabel.text = "This view controller is \(title)"
        }
    }

    lazy var titleLabel: UILabel = {
        let size: CGSize = CGSize(width: self.view.bounds.width, height: ceil(Constants.TitleFont.lineHeight))
        let frame: CGRect = CGRect(x: 0.0, y: (self.view.bounds.height - size.height)/2.0, width: size.width, height: size.height)
        let label: UILabel = UILabel(frame: frame)
        label.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        label.font = Constants.TitleFont
        return label
    }()
}

