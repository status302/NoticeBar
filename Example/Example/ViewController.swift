//
//  ViewController.swift
//  Example
//
//  Created by 程庆春 on 2016/12/10.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit
import NoticeBar

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    lazy var stylesStr: [String] = {
        return ["onStatusBar", "onNavigationBar", "onTabbar", "belowStatusBar"]
    }()
    lazy var animationsTypesStr: [String] = {
         return ["top", "bottom", "left", "right"]
    }()

    lazy var styles: [NoticeBarStyle] = {
        return [.onStatusBar, .onNavigationBar, .onTabbar, .belowStatusBar]
    }()

    lazy var animationsTypes: [NoticeBarAnimationType] = {
        return [.top, .bottom, .left, .right]
    }()
    lazy var defaultTypes: [NoticeBarDefaultType] = {
        return [.info, .attention, .success, .error]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            self.navigationItem.title = "NoticeBar Example"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showNoticeBar(_ sender: Any) {

        let noticeBar = NoticeBar(title: "haha", defaultType: .error)
        noticeBar.show(duration: 1.8, completed: {
            (finished: Bool) in
        })
    }

    // MARK: - tableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return stylesStr.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == stylesStr.count) {
            return defaultTypes.count
        }
        return animationsTypesStr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.section == stylesStr.count) {
            cell.textLabel?.text = defaultTypes[indexPath.row].rawValue
            cell.detailTextLabel?.text = ""
        } else {
            cell.textLabel?.text = stylesStr[indexPath.section]
            cell.detailTextLabel?.text = animationsTypesStr[indexPath.row]
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == stylesStr.count) {
            let noticeBar = NoticeBar(title: "\(defaultTypes[indexPath.row].rawValue)", defaultType: defaultTypes[indexPath.row])
            noticeBar.show(duration: 2.0, completed: { (finished) in

            })
        } else {
            let config = NoticeBarConfig(title: "\(stylesStr[indexPath.section]) with \(animationsTypesStr[indexPath.row]) animation", image: #imageLiteral(resourceName: "notice_bar_example"), textColor: UIColor.white, backgroundColor: UIColor.red, barStyle: styles[indexPath.section], animationType: animationsTypes[indexPath.row])
            let noticeBar = NoticeBar(config: config)
            if styles[indexPath.section] != .onTabbar {
                UIApplication.shared.statusBarStyle = .lightContent
            }
            noticeBar.show(duration: 2.0, completed: {
                (finished) in
                if finished {
                    UIApplication.shared.statusBarStyle = .default
                }
            })
        }
    }

}

