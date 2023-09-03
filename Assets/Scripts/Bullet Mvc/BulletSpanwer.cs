using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletSpanwer : MonoBehaviour
{

   
    public BulletView view;

    public  void SpawnBullet(Transform spawnPoint,GameObject bulletPrefab)
    {
            GameObject bulletSpawned= GameObject.Instantiate(bulletPrefab);
        bulletSpawned.transform.localPosition = spawnPoint.position;
        bulletSpawned.transform.localRotation = spawnPoint.rotation;
        bulletSpawned.GetComponent<Rigidbody>().AddForce((spawnPoint.forward * 2000), ForceMode.Force);

    }

   
}
