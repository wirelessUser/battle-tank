using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyHealth : MonoBehaviour
{
    public GameObject explosionPrefab;
    [Range(10, 100)]
    public float maxHealth;
    public float currentHealth;

    

    private void Awake()
    {
        currentHealth = maxHealth;
    }

    public void Death()
    {

        ExplosionEffect();
        StartCoroutine(EnemyDeath(this.gameObject));


    }

    private void OnEnable()
    {
        PlayerHealth playerRef = FindFirstObjectByType<PlayerHealth>();
        if (playerRef.gameObject != null)
        {
            Debug.Log("Calling OnEnable() enemy Event.....");
            playerRef.DestroyAll += Death;
        }
    }


    private void OnDisable()
    {
        PlayerHealth playerRef = FindFirstObjectByType<PlayerHealth>();
        if (playerRef.gameObject != null)
        {
            Debug.Log("Calling OnDisable() enemy Event.....");
            playerRef.DestroyAll -= Death;
        }
    }


    public void ExplosionEffect()
    {
        GameObject explosion = Instantiate(explosionPrefab);
        explosion.transform.position = this.gameObject.transform.localPosition;
    }
    private IEnumerator EnemyDeath(GameObject gameObject)
    {

        yield return new WaitForSeconds(0.1f);
        Destroy(gameObject);

    }


    public void DecreaseHealth(float amount)
    {
        if (currentHealth <= 0)
        {
            Death();

        }
        currentHealth -= amount;

    }
}
