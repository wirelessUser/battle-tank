using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyController 
{
    public EnemyView view;
    public EnemyModel model;

    public List<int> spawnPointList;

    public List<int> EnemySpawnList;

    public  EnemyController(EnemyView _view, EnemyModel _model)
    {
        view = _view;
        model = _model;

        view.SetEnemyController(this);
        model.SetEnemyController(this);

    }

  

    public void InstantiateEnemies(List<EnemyView>  enemyprefbas,Transform[] spawnePoints)
    {
      
        for (int i = 0; i < enemyprefbas.Count; i++)
        {
         //   Debug.Log($"enemyprefbas[i].name = {enemyprefbas[i].name},count=={enemyprefbas.Count}");
        
            EnemyView enemyInst = GameObject.Instantiate(enemyprefbas[i]);
          
            enemyInst.transform.position = spawnePoints[i].position;
           // Debug.Log($"enemyInst.transform.position"+ enemyInst.transform.position);

        }
        



    }


    public Vector3 GetRandomPos(Transform[] spawnePoints)
    {
        int randomPos = -1;

        do
        {
            randomPos = Random.Range(0, spawnePoints.Length);
        } while (spawnPointList.Contains(randomPos));

        spawnPointList.Add(randomPos);
        Debug.Log($"spawnePoints[randomPos].position = {spawnePoints[randomPos].position}");
        return spawnePoints[randomPos].position;
    }



    //public Vector3 GetRandomPos(Transform[] spawnePoints)
    //{
    //    int randomPos = -1;

    //    do
    //    {
    //        randomPos = Random.Range(0, spawnePoints.Length);
    //    } while (spawnPointList.Contains(randomPos));

    //    spawnPointList.Add(randomPos);
    //    Debug.Log($"spawnePoints[randomPos].position = {spawnePoints[randomPos].position}");
    //    return spawnePoints[randomPos].position;
    //}

    public EnemyView GetRandomEnemy(List<EnemyView> enemyprefbas)
    {
        int randomPos = -1;

        do
        {
            randomPos = Random.Range(0, enemyprefbas.Count);
        } while (EnemySpawnList.Contains(randomPos));

        EnemySpawnList.Add(randomPos);

        return enemyprefbas[randomPos];

    }


}
