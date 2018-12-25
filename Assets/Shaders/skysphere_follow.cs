using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class skysphere_follow : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	

	void Update ()
	{
		transform.position = Camera.main.transform.position;
	}
}
