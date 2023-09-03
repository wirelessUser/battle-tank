using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyView : MonoBehaviour,IinitializeVariables
{
    public EnemyController enemyController;
    public GameObject[] dustTrailEffects;



    private void Awake()
    {

        InitializeVariables();
    }

    public void InitializeVariables()
    {
        dustTrailEffects[0].SetActive(false);
        dustTrailEffects[1].SetActive(false);
    }
    public void SetEnemyController(EnemyController _enemyController)
    {
        enemyController = _enemyController;
    }


    public void PlayParticleTrailEffect(bool isActive)
    {
        foreach (GameObject trail in dustTrailEffects)
        {
            trail.SetActive(isActive);
        }

    }

   
}
