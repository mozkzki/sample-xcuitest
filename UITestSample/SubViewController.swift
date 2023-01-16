//
//  SubViewController.swift
//  UITestSample
//
//  Created by mozkzki on 2023/01/13.
//  Copyright © 2023 mozksoft. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    // MARK: - UI Parts
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text =
        """
        XCUITestのサンプル
        (sub view)
        """
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.boldSystemFont(ofSize: 25)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.accessibilityIdentifier = "SubViewController-textView"
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("押してください", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.accessibilityIdentifier = "SubViewController-button"
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .gray
        label.accessibilityIdentifier = "SubViewController-label"
        return label
    }()
    
    // MARK: - UIViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        view.addSubview(label)
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
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        label.sizeToFit()
    }
}

// MARK: - Actions

extension SubViewController {
    @objc func tappedButton(_ sender: Any?) {
        let actionSheet = UIAlertController(title: "タイトルです", message: "メッセージです", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "アクション 1", style: .default, handler: {
            (action: UIAlertAction!) in
            self.label.text = "アクション 1 が押されました"
        })
        
        let action2 = UIAlertAction(title: "アクション 2", style: .default, handler: {
            (action: UIAlertAction!) in
            self.label.text = "アクション 2 が押されました"
        })
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {
            (action: UIAlertAction!) in
            self.label.text = ""
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}
