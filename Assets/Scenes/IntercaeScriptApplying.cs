using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IntercaeScriptApplying : MonoBehaviour, MyIntercae 

{
    public MyIntercae inter;
    private void Awake()
    {
        inter= gameObject.GetComponent<MyIntercae>();
    }
    public void Starts()
    {
        Debug.Log("getting???????");
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
