//
//  ViewController.swift
//  EggTimer
//
//  Created by Sonata Girl on 27.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player : AVAudioPlayer?
    let eggTimes = ["Soft" : 5, "Medium" : 7, "Hard" : 12]
    
    var totaltime = 0
    var secondPassed = 0
    var timer = Timer()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 39
        stackView.alignment = .center
        return stackView
    }()
    
    private let eggStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 20
       return stackView
    }()
    
    private let timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 20
       return stackView
    }()
    
    private let titleView = UIView()
    private let softEggView = UIView()
    private let mediumEggView = UIView()
    private let hardEggView = UIView()
    private let timerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "How do you like your eggs?"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "0 second"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private let softEggImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "soft_egg")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let softEggButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Soft", for: .normal)
        return button
    }()
    
    private let mediumEggImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "medium_egg")
        imageView.contentMode = .scaleAspectFit
       return imageView
    }()
    
    private let mediumEggButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Medium", for: .normal)
        return button
    }()
    
    private let hardEggImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "hard_egg")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let hardEggButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hard", for: .normal)
        return button
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .orange
//        progressView.progress = 1.0
    
        return progressView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8327679634, green: 0.9538795352, blue: 0.9372531176, alpha: 1)
        setupUI()
    }

    private func setupUI() {
        
        view.addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        verticalStackView.addArrangedSubview(titleView)
        titleView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
        
        verticalStackView.addArrangedSubview(eggStackView)
        verticalStackView.addArrangedSubview(timerStackView)
      
        timerStackView.addArrangedSubview(timerLabel)

        timerStackView.addArrangedSubview(timerView)
        timerView.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
                
        eggStackView.addArrangedSubview(softEggView)
        eggStackView.addArrangedSubview(mediumEggView)
        eggStackView.addArrangedSubview(hardEggView)
        
        softEggView.addSubview(softEggImageView)
        NSLayoutConstraint.activate([
            softEggImageView.topAnchor.constraint(equalTo: softEggView.topAnchor),
            softEggImageView.leadingAnchor.constraint(equalTo: softEggView.leadingAnchor),
            softEggImageView.trailingAnchor.constraint(equalTo: softEggView.trailingAnchor),
            softEggImageView.bottomAnchor.constraint(equalTo: softEggView.bottomAnchor)
        ])
        softEggView.addSubview(softEggButton)
        NSLayoutConstraint.activate([
            softEggButton.topAnchor.constraint(equalTo: softEggView.topAnchor),
            softEggButton.leadingAnchor.constraint(equalTo: softEggView.leadingAnchor),
            softEggButton.trailingAnchor.constraint(equalTo: softEggView.trailingAnchor),
            softEggButton.bottomAnchor.constraint(equalTo: softEggView.bottomAnchor)
        ])
        
        mediumEggView.addSubview(mediumEggImageView)
        NSLayoutConstraint.activate([
            mediumEggImageView.topAnchor.constraint(equalTo: mediumEggView.topAnchor),
            mediumEggImageView.leadingAnchor.constraint(equalTo: mediumEggView.leadingAnchor),
            mediumEggImageView.trailingAnchor.constraint(equalTo: mediumEggView.trailingAnchor),
            mediumEggImageView.bottomAnchor.constraint(equalTo: mediumEggView.bottomAnchor)
        ])
        mediumEggView.addSubview(mediumEggButton)
        NSLayoutConstraint.activate([
            mediumEggButton.topAnchor.constraint(equalTo: mediumEggView.topAnchor),
            mediumEggButton.leadingAnchor.constraint(equalTo: mediumEggView.leadingAnchor),
            mediumEggButton.trailingAnchor.constraint(equalTo: mediumEggView.trailingAnchor),
            mediumEggButton.bottomAnchor.constraint(equalTo: mediumEggView.bottomAnchor)
        ])
        
        hardEggView.addSubview(hardEggImageView)
        NSLayoutConstraint.activate([
            hardEggImageView.topAnchor.constraint(equalTo: hardEggView.topAnchor),
            hardEggImageView.leadingAnchor.constraint(equalTo: hardEggView.leadingAnchor),
            hardEggImageView.trailingAnchor.constraint(equalTo: hardEggView.trailingAnchor),
            hardEggImageView.bottomAnchor.constraint(equalTo: hardEggView.bottomAnchor)
        ])
        hardEggView.addSubview(hardEggButton)
        NSLayoutConstraint.activate([
            hardEggButton.topAnchor.constraint(equalTo: hardEggView.topAnchor),
            hardEggButton.leadingAnchor.constraint(equalTo: hardEggView.leadingAnchor),
            hardEggButton.trailingAnchor.constraint(equalTo: hardEggView.trailingAnchor),
            hardEggButton.bottomAnchor.constraint(equalTo: hardEggView.bottomAnchor)
        ])
        
        softEggButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        mediumEggButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        hardEggButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
   
    }
    
    @objc private func selected(_ sender: UIButton) {
        timer.invalidate()
        let buttonType = sender.currentTitle
        
        totaltime = eggTimes[buttonType ?? ""] ?? 0
        
        progressView.progress = 0.0
        secondPassed = 0
        titleLabel.text = buttonType

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondPassed <= totaltime {
            print("\(secondPassed) seconds")
            secondPassed += 1
            let percentageProgress: Float = Float(secondPassed) / Float(totaltime)
            
            progressView.progress = Float(percentageProgress)
            timerLabel.text = "\(secondPassed) second"
                 
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
        }
        

    }

    func playSound() {
          guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}

          do{
              try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
              try AVAudioSession.sharedInstance().setActive(true)
              
              player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
              guard let player = player else {return}
              player.play()
              
          } catch let error {
              print(error.localizedDescription)
          }
      }
}

