using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow :MonoBehaviour
{
    




    public void CameraSetup(PlayerTankView player)
    {
        transform.SetParent(player.transform);
        transform.localPosition = new Vector3(0f, 4, -2.51f);

    }
}
