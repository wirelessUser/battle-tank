using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerShootingBehaviour : MonoBehaviour,IShootBullet
{
    public Transform spawnPoint;
    public GameObject bulletPrefab;
    public BulletSpanwer bulletSpawner;

    public PlayerTankView playerRef;

    private void Start()
    {
        playerRef = FindFirstObjectByType<PlayerTankView>();
    }
    public  void ShootBullet()
    {
        if(playerRef!=null)
        bulletSpawner.SpawnBullet(spawnPoint,BulletEnum.PlayerBullet);
      
    }
}
