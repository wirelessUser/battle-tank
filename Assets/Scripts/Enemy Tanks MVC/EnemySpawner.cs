using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySpawner : EventManager<EnemySpawner>
{
    public EnemyView view;
    public EnemyModel model;
    public List<EnemyView> enemyPrefab;
    public Transform[] spawnPoints;

    void Awake()
    {
        model = new EnemyModel();
      
     
    }


    private void Start()
    {
        transform.position = new Vector3(2, 3, 4);
        EnemyController controller = new EnemyController(view, model);
        controller.InstantiateEnemies(enemyPrefab, spawnPoints);
    }

    // Update is called once per frame
    void Update()
    {
      
    }
}
