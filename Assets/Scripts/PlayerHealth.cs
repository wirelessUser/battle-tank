using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.ParticleSystemJobs;
public class PlayerHealth :MonoBehaviour,ITakeDamage
{
  
  

    public GameObject explosionPrefab;
    [Range(10,100)]
    public float maxHealth;
    public float currentHealth;

   

    private void Awake()
    {
        currentHealth = maxHealth;
    }


  

    public void Death()
    {
                                     
        ExplosionEffect();             // Playing Particle effect for the Player  ...

       
                   // Destroing Enemy &Environment After Destroing the Player...
       
        StartCoroutine(PlayerDeath(this.gameObject));
        PlayerTankSpawner.Instance.PlayerDeathEvent();     // Destroing The Player  After Destroing the Player...



    }


    public void ExplosionEffect()
    {
        GameObject explosion = Instantiate(explosionPrefab );
        explosion.transform.position = this.gameObject.transform.localPosition;
    }
    private   IEnumerator PlayerDeath(GameObject gameObject)
    {

        yield return new WaitForSeconds(0.1f);
       Destroy(gameObject);
       
    }


  

    public void TakeDamage(float damageAmount)
    {
        if (currentHealth <= 0)
        {
            Death();

        }
        currentHealth -= damageAmount;
    }
}
