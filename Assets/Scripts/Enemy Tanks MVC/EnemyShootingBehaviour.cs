using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyShootingBehaviour :MonoBehaviour
{
    public BulletSpanwer bulletSpawner;
    public Transform SpawnPoint;
    public GameObject bulletPrefab;


    public void ShootBullet()
    {
        bulletSpawner.SpawnBullet(SpawnPoint, bulletPrefab);
    }

}
