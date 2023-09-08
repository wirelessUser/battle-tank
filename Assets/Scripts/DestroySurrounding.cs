using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroySurrounding : MonoBehaviour
{
    public GameObject floor;


    public PlayerHealth playerRef;

    private void Awake()
    {
        playerRef = PlayerTankSpawner.Instance.ReturnPlayerHealth();
        //*Problem---This surrounding script attached to the Environment which is
        // Already present in the scene ,But player is Created at runtime,So here the awake will get called first and at tat time player will not be created
        //in the scene ,So how can resolve that problem?  ** Do i have to change the script Execution Order ? Or is thre any other Best Solution for that ?
    }


    private void OnEnable()
    {
      
        if (playerRef.gameObject != null)
        {
            playerRef.DestroyAll += DestroyFloor;
            //playerRef.DestroyAll = null;
        }
    }





    private void OnDisable()
     {
      
        if (playerRef.gameObject != null)
        {
            playerRef.DestroyAll -= DestroyFloor;
        }
     }

 

    public void DestroyFloor()
    {
       
        StartCoroutine(DestroyFloorCoroutine());
    }
    private IEnumerator DestroyFloorCoroutine()
    {
        //  destroying  the floor Slowly
        float destroyTime = 5f;
        float startTime = Time.time;
        Vector3 initialScale = floor.transform.localScale;

        while (Time.time - startTime < destroyTime)
        {
            float progress = (Time.time - startTime) / destroyTime;
            floor.transform.localScale = Vector3.Lerp(initialScale, Vector3.zero, progress);
            yield return null;
        }

        // Destroy the floor object.
        Destroy(floor);
    }
}
