using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow :MonoBehaviour
{
    




    public void CameraSetup(PlayerTankView player)
    {
        transform.SetParent(player.transform);
        transform.localPosition = new Vector3(1f, 5.9f, -11.9f);
        Vector3 rotationAngle= new Vector3(10.14f, -5.5f, 0f);
        transform.localRotation = Quaternion.Euler(rotationAngle);

    }
}

//Vector3(17.3599968,7.66000271,0)