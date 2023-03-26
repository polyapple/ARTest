//
//  ViewController.swift
//  ARTest
//
//  Created by polymac on 2023/03/26.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
    }
    
    private func setupSceneView() {
    sceneView.delegate = self
    // view의 delegate 설정
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetTracking()
    }

    func resetTracking() {
        let configuration = ARFaceTrackingConfiguration()
        
        // sceneView.automaticallyUpdatesLighting = true
        configuration.isLightEstimationEnabled = true
        // 조명 효과 설정
        
        sceneView.session.run(configuration,
                              options: [.resetTracking, .removeExistingAnchors])
    }
    // tracking reset옵션 추가
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

/* 소스를 노드에 load하는 함수 */
extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard anchor is ARFaceAnchor else { return nil }
        
        let resourceName = "coordinateOrigin"
        let url = Bundle.main.url(forResource: resourceName, withExtension: "scn", subdirectory: "art.scnassets")!
        
        let contentNode = SCNReferenceNode(url: url)
        contentNode?.load()
        
        return contentNode
        }
}
