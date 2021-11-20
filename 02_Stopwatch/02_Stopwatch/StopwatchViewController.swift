//
//  StopwatchViewController.swift
//  02_Stopwatch
//
//  Created by rae on 2021/11/18.
//

import UIKit

class StopwatchViewController: UIViewController {
    private let viewMultipier: CGFloat = 1/5
    // 기본 네비게이션 색이 나타나지 않아서 따로 변수로 설정
    private let defaultLightGray: UIColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1.0)
    private let buttonSize: CGFloat = 80
    
    private let stopwatch = Stopwatch()
    
    private let clockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let smallTotalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bigTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.font = UIFont.systemFont(ofSize: 48, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = defaultLightGray
        return view
    }()
    
    private lazy var lapButton: UIButton = {
        // 클릭할 때 아무 애니메이션이 없어서 system type으로 설정
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Lap", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(touchLapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(touchStartStopButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = defaultLightGray
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = defaultLightGray
        setViews()
    }

    private func setViews() {
        view.addSubview(clockView)
        NSLayoutConstraint.activate([
            clockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockView.widthAnchor.constraint(equalTo: view.widthAnchor),
            clockView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewMultipier)
        ])
        
        clockView.addSubview(smallTotalTimeLabel)
        clockView.addSubview(bigTimeLabel)
        NSLayoutConstraint.activate([
            bigTimeLabel.centerXAnchor.constraint(equalTo: clockView.centerXAnchor),
            bigTimeLabel.centerYAnchor.constraint(equalTo: clockView.centerYAnchor),
            smallTotalTimeLabel.bottomAnchor.constraint(equalTo: bigTimeLabel.topAnchor),
            smallTotalTimeLabel.trailingAnchor.constraint(equalTo: bigTimeLabel.trailingAnchor)
        ])
        
        view.addSubview(buttonView)
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: clockView.bottomAnchor),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonView.heightAnchor.constraint(equalTo: clockView.heightAnchor)
        ])
        
        buttonView.addSubview(lapButton)
        buttonView.addSubview(startStopButton)
        NSLayoutConstraint.activate([
            lapButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            lapButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: -buttonSize),
            lapButton.widthAnchor.constraint(equalToConstant: buttonSize),
            lapButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            startStopButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            startStopButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: buttonSize),
            startStopButton.widthAnchor.constraint(equalToConstant: buttonSize),
            startStopButton.heightAnchor.constraint(equalToConstant: buttonSize),
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: buttonView.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func touchLapButton(_ sender: UIButton) {
    }
    
    @objc func touchStartStopButton(_ sender: UIButton) {
        if stopwatch.isCounting {
            stopwatch.timer.invalidate()
            stopwatch.isCounting = false
            startStopButton.setTitle("Start", for: .normal)
            startStopButton.setTitleColor(.green, for: .normal)
        } else {
            stopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            stopwatch.isCounting = true
            startStopButton.setTitle("Stop", for: .normal)
            startStopButton.setTitleColor(.red, for: .normal)
        }
        
    }
    
    @objc func updateTimer() {
        stopwatch.count += 0.035
        let minute = Int(stopwatch.count / 60)
        let textMinute = minute < 10 ? "0\(minute)" : "\(minute)"
        
        // double형에서는 % 사용 못함
        let second = stopwatch.count.truncatingRemainder(dividingBy: 60)
        let textSecond = second < 10 ? "0\(String(format: "%.2f", second))" : "\(String(format: "%.2f", second))"
        bigTimeLabel.text = textMinute + ":" + textSecond
        
    }
}

