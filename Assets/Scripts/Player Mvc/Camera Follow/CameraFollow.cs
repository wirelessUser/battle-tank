using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow :MonoBehaviour
{
    




    public void CameraSetup(PlayerTankView player)
    {
        transform.SetParent(player.transform);
        transform.localPosition = new Vector3(-0.34f, 4.31f, -6.81f);

    }
}

//Vector3(17.3599968,7.66000271,0)