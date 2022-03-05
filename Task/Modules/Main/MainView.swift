//
//  MainView.swift
//
//

import UIKit

class MainView: UIView {
    private enum Constants {
        static let leftMargin: CGFloat = 30
        static let buttonWidth: CGFloat = 100
        static let buttonHeight: CGFloat = 60
    }
        
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("start".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("stop".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
}

// MARK: - UI Setup
extension MainView {
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        [startButton, stopButton, errorLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            startButton.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftMargin),
            startButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            startButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            stopButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            stopButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.leftMargin),
            stopButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            stopButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            errorLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            errorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.leftMargin),
            errorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.leftMargin)
        ])
    }
}
