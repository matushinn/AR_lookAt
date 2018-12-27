//
//  ShipNode.swift
//  AR_lookAt
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import ARKit

class ShipNode: SCNNode {
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(){
        super.init()
        //art.scnassets/ship.scnからshipノードを作る
        let sceneURL = Bundle.main.url(forResource:"ship",withExtension:"scm",subdirectory:"art.scnassets")!
        //ノードを作る
        let ship = SCNReferenceNode(url: sceneURL)
        //データをノードに読み込む
        ship?.load()
        //機首をZ軸の正方向に向ける
        //90度回転
        ship?.eulerAngles.y = -.pi
        //半分のサイズにする
        self.addChildNode(ship!)
        //20%に縮小
        self.scale = SCNVector3Make(0.2, 0.2, 0.2)
        
    }
}



