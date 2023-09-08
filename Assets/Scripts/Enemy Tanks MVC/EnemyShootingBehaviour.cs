using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyShootingBehaviour :MonoBehaviour, IShootBullet
{
    public BulletSpanwer bulletSpawner;
    public Transform spawnPoint;
    // public GameObject bulletPrefab;

    private void Update()
    {
        
    }
    public void ShootBullet()
    {
        bulletSpawner.SpawnBullet(spawnPoint, BulletEnum.EnemyBullet,this.gameObject);
    }

}
