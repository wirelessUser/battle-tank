using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAttackState : PlayerStates, IShootBullet
{
    public Transform spawnPoint;
    public GameObject bulletPrefab;
    public BulletSpanwer bulletSpawner;

    public PlayerTankView playerRef;
    private  void Awake()
    {
        playerRef = FindFirstObjectByType<PlayerTankView>();
    }
    public override void OnPlayerEnterState()
    {
        base.OnPlayerEnterState();
    }
    public override void OnPlayerExitState()
    {
        base.OnPlayerExitState();   
        
    }
    public  override void Update()
    {      
        if (Input.GetKeyDown(KeyCode.Space)){ShootBullet();}
    }
    public void ShootBullet()
    {
        if (playerRef != null)
            bulletSpawner.SpawnBullet(spawnPoint, BulletEnum.PlayerBullet, this.gameObject);

    }
}
