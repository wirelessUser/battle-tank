using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletSpanwer : MonoBehaviour
{

   
    public GameObject[] view;

    public  void SpawnBullet(Transform spawnPoint, BulletEnum bulletType)
    {
        GameObject bulletSpawned = null;
        if (bulletType == BulletEnum.PlayerBullet)
        {
             bulletSpawned = GameObject.Instantiate(view[(int)bulletType]);
        }
        else if (bulletType == BulletEnum.EnemyBullet)
        {
           // Debug.Log("Creating Enemy Bullet");
             bulletSpawned = GameObject.Instantiate(view[(int)bulletType]);
            
        }
          
        bulletSpawned.transform.localPosition = spawnPoint.position;
        bulletSpawned.transform.localRotation = spawnPoint.rotation;
        float speed = bulletSpawned.GetComponent<BulletView>().bulletSo.speed;
        bulletSpawned.GetComponent<Rigidbody>().AddForce((spawnPoint.forward * speed), ForceMode.Force);

    }
   

}
