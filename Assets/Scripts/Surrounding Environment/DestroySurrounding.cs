using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroySurrounding : MonoBehaviour
{
    public GameObject floor;


    private void OnEnable()
    {

        PlayerTankSpawner.Instance.onPlayerDeath += DestroyFloor;
 
    }





    private void OnDisable()
     {

        PlayerTankSpawner.Instance.onPlayerDeath -= DestroyFloor;
     }

 

    public void DestroyFloor()
    {
       
        StartCoroutine(DestroyFloorCoroutine());
    }
    private IEnumerator DestroyFloorCoroutine()
    {
  
        yield return new WaitForSeconds(2);

        // Destroy the floor object.
        Destroy(floor);
    }
}
