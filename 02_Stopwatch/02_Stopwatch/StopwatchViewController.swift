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
    
    private let totalStopwatch = Stopwatch()
    private let lapStopwatch = Stopwatch()
    private var isTimerPlaying: Bool = false
    private var laps: [String] = []
    
    private let clockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let lapTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalTimeLabel: UILabel = {
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
    
    private lazy var lapResetButton: UIButton = {
        // 클릭할 때 아무 애니메이션이 없어서 system type으로 설정
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Lap", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = buttonSize / 2
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(touchLapResetButton(_:)), for: .touchUpInside)
        button.isEnabled = false
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
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = defaultLightGray
        setViews()
        
        tableView.register(LapTableViewCell.self, forCellReuseIdentifier: LapTableViewCell.identifier)
    }

    private func setViews() {
        view.addSubview(clockView)
        NSLayoutConstraint.activate([
            clockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockView.widthAnchor.constraint(equalTo: view.widthAnchor),
            clockView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: viewMultipier)
        ])
        
        clockView.addSubview(lapTimeLabel)
        clockView.addSubview(totalTimeLabel)
        NSLayoutConstraint.activate([
            totalTimeLabel.centerXAnchor.constraint(equalTo: clockView.centerXAnchor),
            totalTimeLabel.centerYAnchor.constraint(equalTo: clockView.centerYAnchor),
            lapTimeLabel.bottomAnchor.constraint(equalTo: totalTimeLabel.topAnchor),
            lapTimeLabel.trailingAnchor.constraint(equalTo: totalTimeLabel.trailingAnchor)
        ])
        
        view.addSubview(buttonView)
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: clockView.bottomAnchor),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttonView.heightAnchor.constraint(equalTo: clockView.heightAnchor)
        ])
        
        buttonView.addSubview(lapResetButton)
        buttonView.addSubview(startStopButton)
        NSLayoutConstraint.activate([
            lapResetButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            lapResetButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: -buttonSize),
            lapResetButton.widthAnchor.constraint(equalToConstant: buttonSize),
            lapResetButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
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

    @objc func touchLapResetButton(_ sender: UIButton) {
        if isTimerPlaying {
            // Lap 기록 및 lapTimeLabel 초기화
            if let totalTimeLabelText = totalTimeLabel.text {
                laps.append(totalTimeLabelText)
            }
            
            tableView.reloadData()
            resetLapTimer()
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
        } else {
            // 테이블뷰 초기화 및 전체 label 초기화
            resetTotalTimer()
            resetLapTimer()
            lapResetButton.setTitle("Lap", for: .normal)
            lapResetButton.isEnabled = false
        }
    }
    
    @objc func touchStartStopButton(_ sender: UIButton) {
        lapResetButton.isEnabled = true
        
        if isTimerPlaying {
            totalStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isTimerPlaying = false
            
            startStopButton.setTitle("Start", for: .normal)
            startStopButton.setTitleColor(.green, for: .normal)
            lapResetButton.setTitle("Reset", for: .normal)
        } else {
            totalStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTotalTimer), userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            isTimerPlaying = true
            
            startStopButton.setTitle("Stop", for: .normal)
            startStopButton.setTitleColor(.red, for: .normal)
            lapResetButton.setTitle("Lap", for: .normal)
        }
    }
    
    @objc func updateLapTimer() {
        updateTimer(stopwatch: lapStopwatch, label: lapTimeLabel)
    }
    
    @objc func updateTotalTimer() {
        updateTimer(stopwatch: totalStopwatch, label: totalTimeLabel)
    }
    
    
    func updateTimer(stopwatch: Stopwatch, label: UILabel) {
        stopwatch.count += 0.035
        let minute = Int(stopwatch.count / 60)
        let textMinute = minute < 10 ? "0\(minute)" : "\(minute)"
        
        // double형에서는 % 사용 못함
        let second = stopwatch.count.truncatingRemainder(dividingBy: 60)
        let textSecond = second < 10 ? "0\(String(format: "%.2f", second))" : "\(String(format: "%.2f", second))"
        label.text = textMinute + ":" + textSecond
    }
    
    func resetTotalTimer() {
        resetTimer(stopwatch: totalStopwatch, label: totalTimeLabel)
        laps.removeAll()
        tableView.reloadData()
    }
    
    func resetLapTimer() {
        resetTimer(stopwatch: lapStopwatch, label: lapTimeLabel)
    }
    
    func resetTimer(stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.count = 0.0
        label.text = "00:00.00"
    }
}

extension StopwatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LapTableViewCell.identifier, for: indexPath) as? LapTableViewCell else {
            fatalError("Unable to dequeue LapTableViewCell")
        }
        
        cell.textLabel?.text = "Laps \(indexPath.row + 1)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        cell.detailTextLabel?.textColor = .black
        
        return cell
    }
}
