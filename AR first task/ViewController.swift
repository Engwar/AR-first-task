//
//  ViewController.swift
//  AR first task
//
//  Created by Igor Shelginskiy on 17/10/2018.
//  Copyright © 2018 Igor Shelginskiy. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show world origin
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //Load Campus
        loadCampus()
        
        loadMainBuilding()
       
    }
    
    func loadCampus(){
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/campus.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    
    func loadMainBuilding() {
        let boxNode = SCNNode()
        let box = SCNBox(width: 3, height: 1, length: 1, chamferRadius: 0)
        box.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        boxNode.geometry = box
        boxNode.position.y += 0.001
        
        let planeNode = SCNNode()
        let plane = SCNPlane(width: 3.5, height: 1.5)
        plane.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        planeNode.geometry = plane
        planeNode.eulerAngles.x += -.pi/2
        planeNode.position.y -= 0.5
        
        let campusNode = SCNNode()
        campusNode.position = SCNVector3(0, -1, -3)
        campusNode.scale = SCNVector3(0.5, 0.5, 0.5)
        campusNode.addChildNode(boxNode)
        campusNode.addChildNode(planeNode)
        sceneView.scene.rootNode.addChildNode(campusNode)
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
