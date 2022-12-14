"use strict";

import * as THREE from "three";

export class Reference {
    constructor() {
        this.geometry = new THREE.PlaneGeometry(2.0, 2.0);
        this.material = new THREE.MeshBasicMaterial({ color: 0x3f3f3f });
        this.mesh = new THREE.Mesh(this.geometry, this.material);
        this.mesh.rotation.x = -90 * Math.PI / 180.0;
        this.mesh.position.z = -2;
        this.mesh.visible = false;
    }

    into(scene) {
        scene.add(this.mesh);
    }

    destroy() {
        this.geometry.dispose();
        this.material.dispose();
    }
}
