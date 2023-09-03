using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class test : MonoBehaviour
{


    public List<GameObject> go;




    private void Awake()
    {

        go = new List<GameObject>();
    }

    private void Start()
    {
        Instantiate(go[0], transform.position,Quaternion.identity);
    }
    //private IEnumerator Start()
    //{
    //    Debug.Log("Coroutine started");

    //    for (int i = 0; i < 10; i++)
    //    {
    //        Debug.Log("Step " + i);
    //        yield return new WaitForSeconds(1f);

    //        if (i == 5)
    //        {
    //            Debug.Log("Exiting coroutine prematurely");
    //            break; // This will exit the coroutine immediately
    //        }
    //    }

    //    Debug.Log("Coroutine finished");
    //}
}
