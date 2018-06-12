//
//  ViewController.swift
//  StrecheyHeader
//
//  Created by Tsunemasa Hachiya on 2018/06/12.
//  Copyright © 2018年 Tsunemasa Hachiya. All rights reserved.
//

import UIKit

struct StretchyHeader {
    var headerHeight: CGFloat {
        return UIScreen.main.bounds.width / (15 / 8) // 画像サイズは15:8
    }
}

class ViewController: UIViewController {

    var headerView : ProfileHeader?
    var screenWidth: CGFloat?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let stretchyHeader = StretchyHeader()
        
        screenWidth = self.view.frame.width
        
        headerView = Bundle.main.loadNibNamed("ProfileHeader", owner: self, options: nil)?.first as? ProfileHeader
        
        headerView?.frame = CGRect(x: 0, y: 0, width: screenWidth!, height: screenWidth! / 2)
        
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "profileCell")
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView = nil
        
        let newHeight = stretchyHeader.headerHeight
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        tableView.addSubview(headerView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCell
        return cell
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        tableView.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if headerView != nil {
            let yPos: CGFloat = -scrollView.contentOffset.y
print(yPos)
            if yPos > 0 {
                var imgRect: CGRect? = headerView?.frame
print(imgRect)
                imgRect?.origin.y = scrollView.contentOffset.y
print(imgRect?.origin.y)
                imgRect?.size.height = (screenWidth! / 2) + yPos - (screenWidth! / 2)
print(imgRect?.size.height)
                headerView?.frame = imgRect!
print(headerView?.frame)
                tableView.sectionHeaderHeight = (imgRect?.size.height)!
            } else {
                print("yPosゼロ以下")
            }
        }
    }
}
