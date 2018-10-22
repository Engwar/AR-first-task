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
        let plane = SCNPlane(width: 5, height: 2)
        plane.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        planeNode.geometry = plane
        planeNode.eulerAngles.x += -.pi/2
        planeNode.position.y -= 0.5
        
        for y in stride(from: Float(-5.0), to: 5.0, by: 0.5) {
            let treeNode = loadTree()
            treeNode.position.x += 2
            treeNode.position.y = y
            treeNode.position.z += 0.25
            planeNode.addChildNode(treeNode)
        }
        
        let campusNode = SCNNode()
        campusNode.position = SCNVector3(0, -1, -3)
        campusNode.scale = SCNVector3(0.5, 0.5, 0.5)
        campusNode.addChildNode(boxNode)
        campusNode.addChildNode(planeNode)
        sceneView.scene.rootNode.addChildNode(campusNode)
    }
    
    func loadTree() -> SCNNode {
        let treeNode = SCNNode()
        let cylinder = SCNCylinder(radius: 0.05, height: 0.5)
        cylinder.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        treeNode.geometry = cylinder
        treeNode.eulerAngles.x -= .pi/2
        
        
        let sphereNode = SCNNode()
        let sphere = SCNSphere(radius: 0.2)
        sphere.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        sphereNode.geometry = sphere
        sphereNode.position.y -= 0.4
        treeNode.addChildNode(sphereNode)
        
        return treeNode
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
