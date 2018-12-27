//
//  ViewController.swift
//  AR_lookAt
//
//  Created by 大江祥太郎 on 2018/12/27.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate,ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        //shipNodeを二機作る
        let shipNode1 = ShipNode()
        shipNode1.position = SCNVector3(0.05,0.05,-0.3)
        let shipNode2 = ShipNode()
        shipNode2.position = SCNVector3(-0.05,-0.15,-0.2)
        
        //シーンを追加する
        sceneView.scene.rootNode.addChildNode(shipNode1)
        sceneView.scene.rootNode.addChildNode(shipNode2)
        
    }
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        //カメラのトランスフォーム
        let tf = frame.camera.transform
        //カメラの位置
        let x = tf.columns.3.x
        let z = tf.columns.3.z
        //shipNodeを取り出す
        for node in sceneView.scene.rootNode.childNodes{
            if node is ShipNode{
                //機首を水平に保つためにY軸はshipNodeの値を利用する
                let pos = SCNVector3(x, node.position.y, z)
                
                //カメラの方向を向く
                node.look(at: pos)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
