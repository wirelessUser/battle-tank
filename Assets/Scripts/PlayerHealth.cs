using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.ParticleSystemJobs;
public class PlayerHealth :MonoBehaviour
{
    public delegate void playerDestrucionChainHandler();

    public event playerDestrucionChainHandler DestroyAll;
  

    public GameObject explosionPrefab;
    [Range(10,100)]
    public float maxHealth;
    public float currentHealth;

   

    private void Awake()
    {
        currentHealth = maxHealth;
    }


    public void NotifyEnemyandEnvironmentDestruction()
    {

        DestroyAll?.Invoke();  //?== null-conditional operator
        
    }

    public void Death()
    {
        // Playing Particle effect for the Player  ...
        ExplosionEffect();

        // Destroing Enemy &Environment After Destroing the Player...
        NotifyEnemyandEnvironmentDestruction();
        // Destroing The Player  After Destroing the Player...
        StartCoroutine(PlayerDeath(this.gameObject));

     

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


    public void DecreaseHealth(float amount)
    {
        if  (currentHealth <= 0)
        {
            Death();

        }
        currentHealth -= amount;

    }
}
