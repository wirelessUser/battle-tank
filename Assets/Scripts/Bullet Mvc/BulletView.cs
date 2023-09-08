using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BulletView : MonoBehaviour, IBulletSpawn, IDestroyObject
{
    public BulletController controller;

    public BulletScriptableObject bulletSo;
    public Rigidbody rb;

    public GameObject owner;
  


    public void SetOwner(GameObject _owner)  //## i am checking collsion isnde the bulletView script (if any obejct implements ITakedamge() interface
                                             //then bullet will give damage to it ,But i want to make sure that Bulet dont give damage to it's Spanwer(Player Or Enemy).
                                             // So i am Setting the reference of the Spaener  here from the BulletSpawenr Script.
    {
        owner = _owner;

    }
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
      
       if(collision.TryGetComponent<ITakeDamage>(out var damage)&& collision.gameObject != owner)
        {
           
            damage.TakeDamage(10);
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
