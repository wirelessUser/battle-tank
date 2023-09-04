using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroySurrounding : MonoBehaviour
{
    public GameObject floor;
   // public PlayerHealth playerRef;


    private void Start()
    {
        // playerRef = FindFirstObjectByType<PlayerHealth>();
    }
    private void OnEnable()
    {
        PlayerHealth playerRef = FindFirstObjectByType<PlayerHealth>();
        if (playerRef.gameObject != null)
        {
            playerRef.DestroyAll += DestroyFloor;
        }
    }


   


        private void OnDisable()
    {
       PlayerHealth playerRef = FindFirstObjectByType<PlayerHealth>();
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
