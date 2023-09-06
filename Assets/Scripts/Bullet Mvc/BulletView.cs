using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletView : MonoBehaviour, IBulletSpawn, IDestroyObject
{
    public BulletController controller;

    public BulletScriptable bulletSo;
    public Rigidbody rb;
   

    private void Start()
    {
        StartCoroutine(Destroy(5));
    }
    public IEnumerator Destroy(float time)
    {
        yield return new WaitForSeconds(time);
        Destroy(gameObject);
    }

    public void SetBulletController(BulletController  _controller)
    {
        controller = _controller;
    }

 

    private void OnTriggerEnter(Collider collision)
    {
        if (this.bulletSo.bulletType == BulletEnum.EnemyBullet)
        {
           // Debug.Log("Destroing Bullet...Enemy");
            if (collision.gameObject.GetComponent<PlayerTankView>() != false )
            {
                collision.gameObject.GetComponent<PlayerHealth>().DecreaseHealth(10);
                Destroy(this.gameObject);
            }
        }
       

        if (this.bulletSo.bulletType == BulletEnum.PlayerBullet)
        {
          //  Debug.Log("Destroing Bullet...Player");
            if (collision.gameObject.GetComponent<EnemyView>() != false)
            {
                Destroy(this.gameObject);

            }
        }
    }
  

    public void SpawnBullet(Transform spawnPoint)
    {
        BulletModel model = new BulletModel(bulletSo);
        
        BulletView spawnedBullet = controller.SpawnBullet();
        spawnedBullet.transform.position = spawnPoint.position;
        spawnedBullet.transform.rotation = spawnPoint.rotation;
    }

   
}
