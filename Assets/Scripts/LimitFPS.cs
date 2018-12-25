using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LimitFPS : MonoBehaviour {

    public int limit = 30;

	// Use this for initialization
	void Awake () {
        Application.targetFrameRate = limit;
    }
	
	// Update is called once per frame
	void Update () {
		
	}
}
