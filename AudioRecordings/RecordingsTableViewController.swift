//
//  RecordingsTableViewController.swift
//  AudioRecordings
//
//  Created by Jorge Alvarez on 3/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit
import AVFoundation

// AddRecordingSegue
// DetailRecordingSegue

struct Recording {
    var title: String
    var recordingUrl: URL?
    var timestamp: Date
    var length: Double
}

class RecordingsTableViewController: UITableViewController {
    
    var recordings: [Recording] = [Recording(title: "Test",
                                             recordingUrl: URL(string: "piano"),
                                             timestamp: Date(),
                                             length: 69)]

    private lazy var timeIntervalFormatter: DateComponentsFormatter = {
        // NOTE: DateComponentFormatter is good for minutes/hours/seconds
        // DateComponentsFormatter is NOT good for milliseconds, use DateFormatter instead)
        
        let formatting = DateComponentsFormatter()
        formatting.unitsStyle = .positional // 00:00  mm:ss
        formatting.zeroFormattingBehavior = .pad
        formatting.allowedUnits = [.minute, .second]
        return formatting
    }()
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .short
        return df
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recordings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let recording = recordings[indexPath.row]
        cell.textLabel?.text = recording.title
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: recording.timestamp))  - \(timeIntervalFormatter.string(from: recording.length) ?? "")"
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailRecordingSegue" {
            print("DetailRecordingSegue")
            if let detailVC = segue.destination as? AudioRecorderViewController, let indexPath = tableView.indexPathForSelectedRow {
                detailVC.recordings = self.recordings
                detailVC.recording = recordings[indexPath.row]
            }
        }
    }

}
