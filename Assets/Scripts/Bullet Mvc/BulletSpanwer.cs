using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletSpanwer : MonoBehaviour
{

   
    public GameObject[] view;

    public  void SpawnBullet(Transform spawnPoint, BulletEnum bulletType,GameObject owner)
    {
        GameObject bulletSpawned = null;
       
             bulletSpawned = Instantiate(view[(int)bulletType]) ;
        Debug.Log("Bullet Sapwne Enemy....");
        bulletSpawned.GetComponent<BulletView>().SetOwner(owner);

        bulletSpawned.transform.localPosition = spawnPoint.position;
        bulletSpawned.transform.localRotation = spawnPoint.rotation;

        float speed = bulletSpawned.GetComponent<BulletView>().bulletSo.speed;

        bulletSpawned.GetComponent<Rigidbody>().AddForce((spawnPoint.forward * speed), ForceMode.Force);

    }
   

}
