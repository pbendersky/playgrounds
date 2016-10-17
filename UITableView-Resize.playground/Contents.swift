//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class TableViewController: UITableViewController {
    
    enum TableSize {
        case wide
        case narrow
    }
    
    var currentTableSize: TableSize = TableSize.wide
    
    override var navigationItem: UINavigationItem {
        get {
            let navItem = UINavigationItem.init(title: "Test")
            
            let rightBarButtonItem = UIBarButtonItem.init(title: "Animate", style: .plain, target: self, action: #selector(animate))
            
            navItem.rightBarButtonItem = rightBarButtonItem
            
            return navItem
        }
    }
    
    func animate() -> Void {
        var currentFrame = self.tableView.frame
        switch currentTableSize {
        case .wide:
            currentFrame.size.width -= 50
        case .narrow:
            currentFrame.size.width += 50
        }
        
        UIView.animate(withDuration: 3, animations: {
            self.tableView.beginUpdates()
            self.tableView.frame = currentFrame
            self.tableView.endUpdates()
        }) { (completed: Bool) in
            switch self.currentTableSize {
            case .narrow:
                self.currentTableSize = .wide
            case .wide:
                self.currentTableSize = .narrow
            }
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "ID")
        }
        
        cell?.textLabel?.text = "\(indexPath.row)"
        
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
}

let controller = TableViewController.init(style: .plain)

let navigationController = UINavigationController.init(rootViewController: controller)

//controller.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

PlaygroundPage.current.liveView = navigationController
PlaygroundPage.current.needsIndefiniteExecution = true

