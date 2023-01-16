//
//  MainViewController.swift
//  UITestSample
//
//  Created by mozkzki on 2023/01/13.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let textView: UITextView = {
        let textView = UITextView()
        textView.text =
            """
            XCUITestのサンプル
            (main view)
            """
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 25)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.accessibilityIdentifier = "MainViewController-textView"
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("遷移", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.accessibilityIdentifier = "MainViewController-button"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        layout()
    }

    private func layout() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100)
            ])
        textView.sizeToFit()
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        button.sizeToFit()
    }

    @objc func tappedButton(_ sender: Any?) {
        self.navigationController?.pushViewController(SubViewController(), animated: false)
    }
}
